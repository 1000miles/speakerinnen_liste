class IsoLanguage
  def self.all
    # we read the list of language-codes directly from the de translation file
    # to avoid duplication
    I18n.backend.send(:init_translations) unless I18n.backend.initialized?
    translations = I18n.backend.send(:translations)
    translations[:de][:iso_639_1].keys.map(&:to_s).sort
  end

  def self.top_list
    %w{de el en es fr it nl pl pt ru sv tr zh}
  end

  def self.rest_list
    all - top_list
  end

  def self.from_string(str)
    code = case str.length
    when 1
      code_from_single_letter(str)
    when 2
      code_from_two_letter(str)
    else
      code_from_word(str)
    end

    puts "not matched: #{str}" unless code
    code
  end

  def self.code_from_single_letter(str)
    return "de" if str == "D"
    return "en" if str == "E"
    return "fr" if str == "F"
  end

  def self.code_from_two_letter(str)
    I18n.t('iso_639_1').keys.map(&:to_s).find{|iso| iso == str.downcase}
  end

  def self.code_from_word(str)
    lang_name = I18n.t('iso_639_1', locale: :de).values.map(&:to_s).find{|lang| str.downcase =~ Regexp.new(lang)}
    iso = I18n.t('iso_639_1', locale: :de).to_a.map(&:reverse).to_h[lang_name].try(:to_s)
    return iso if iso
    lang_name = I18n.t('iso_639_1', locale: :en).values.map(&:to_s).find{|lang| str.downcase =~ Regexp.new(lang)}
    I18n.t('iso_639_1', locale: :en).to_a.map(&:reverse).to_h[lang_name].try(:to_s)
  end

end
