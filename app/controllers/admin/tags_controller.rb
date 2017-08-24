class Admin::TagsController < Admin::BaseController
  before_filter :find_tag_and_category, only: [:remove_category, :set_category]
  before_action :set_tag, only: [:edit, :update, :destroy, :find_tag_and_category]

  def edit
  end

  def update
    if (existing_tag = ActsAsTaggableOn::Tag.where(name: params[:tag][:name]).first)
      existing_tag.merge(@tag)
      redirect_to categorization_admin_tags_path(page: params[:page]), notice: ("'#{@tag.name}' was merged with the tag '#{existing_tag.name}'.")
    elsif @tag.update_attributes(tag_params)
      redirect_to categorization_admin_tags_path(page: params[:page]), notice: ("'#{@tag.name}' was updated.")
    else
      render action: 'edit'
    end
  end

  def destroy
    @tag.destroy
    redirect_to categorization_admin_tags_path, notice: ("'#{@tag.name}' was destroyed.")
  end

  def remove_category
    @tag.categories.delete @category
    redirect_to categorization_admin_tags_path(page: params[:page], q: params[:q], uncategorized: params[:uncategorized]), alert: ("The tag '#{@tag.name}' is deleted from the category '#{@category.name}'.")
  end

  def set_category
    @tag.categories << @category
    redirect_to categorization_admin_tags_path(page: params[:page], q: params[:q], uncategorized: params[:uncategorized]), notice: ("Just added the tag '#{@tag.name}' to the category '#{@category.name}'.")
  end

  def categorization
    @tags_count = ActsAsTaggableOn::Tag.count
    @tags = TagFilter.new(ActsAsTaggableOn::Tag.all, filter_params)
      .filter
      .order('tags.name ASC')
      .page(params[:page])
      .per(20)
    @categories = Category.all
  end

  private

  def find_tag_and_category
    set_tag
    @category = Category.find(params[:category_id])
  end

  def find_tag_language
    @tag_languages = TagLanguage.all.pluck(:language).uniq
  end

  def set_tag
    @tag      = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def filter_params
     @filter_params = {
      category_id: params[:category_id],
      q: params[:q],
      uncategorized: params[:uncategorized]
      }
  end

  def tag_params
    params.require(:tag).permit(
      :id,
      :tag,
      :name,
      tag_languages: [:id, :tag_id, :language])
  end
end
