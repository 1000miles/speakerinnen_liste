describe 'profile search', type: :view do
  let!(:ada) { FactoryGirl.create(:published, firstname: 'Ada', lastname: 'Lovelace', city: 'London', twitter: 'Adalove', languages: "Spanish, English") }

  context 'on startpage' do
    before { visit root_path }

    describe 'follow link to quick search' do
      before do
        click_button I18n.t(:search, scope: 'pages.home.search')
        #render_template(partial: '_profile_search')
      end

      it 'should show quick search' do
        expect(page).to have_css('#quick-search.visible')
      end

      it 'should hide detailed search' do
        expect(page).to have_css('#detailed-search.hidden')
      end

      it 'should show no profiles because the search field was empty' do
        expect(page).to have_content('no profiles')
      end
    end

    describe 'follow link to detailed search' do
      before do
        click_link I18n.t(:detailed_search, scope: 'general')
      end

      it 'should show the detailed search field' do
        expect(page).to have_css('#detailed-search.visible')
      end

      it 'should hide the quick search field' do
        expect(page).to have_css('#quick-search.hidden')
      end

      it 'should show all profiles' do
        expect(page).to have_content('Ada')
      end
    end

  end

  context 'on profile_search page' do
    before do
      visit root_path
      click_button I18n.t(:search, scope: 'pages.home.search')
      #render_template(partial: '_profile_search')
    end

    describe 'click link detailed search',:js => true, :broken => true do
      before do
        find('#detailed-search-trigger').click
        #render_template(partial: '_profile_search')
      end

      it 'should show detailed search' do
        expect(page).to have_css('#detailed-search.visible')
      end

      it 'should hide quick search' do
        expect(page).to have_css('#quick-search.hidden')
      end
    end
  end

end
