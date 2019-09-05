require_relative '../spec_helper'

describe "Features" do
  describe "authentication" do
    it "displays the username on the page" do
      visit '/auth?code=20'
      expect(page).to have_content 'your_username'
    end
  end

  describe "visiting root" do
    before :each do
      page.set_rack_session(:service => {"access_token" => 1})
      page.set_rack_session(token: "1")
    end

    it "lists repos" do
      visit '/'
      expect(page).to have_content 'Repo 1'
      expect(page).to have_content 'Repo 2'
      expect(page).to have_content 'Repo 3'
    end
  end

  describe "new repo form" do
    before :each do
      page.set_rack_session(:service => {"access_token" => 1})
      page.set_rack_session(token: "1")
    end

    it "creates a new repo", :type => :request do
      stubbed =       stub_request(:post, "https://api.github.com/user/repos").
      with(
        body: {"{\"name\":\"a-new-repo\"}"=>nil},
        headers: {
       'Accept'=>'application/json',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Authorization'=>'token',
       'Content-Type'=>'application/x-www-form-urlencoded',
       'User-Agent'=>'Faraday v0.15.4'
        })
      visit root_path
      fill_in 'new-repo', with: 'a-new-repo'
      click_button 'Create'

      expect(stubbed).to have_been_requested
    end
  end
end
