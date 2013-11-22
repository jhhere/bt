require 'spec_helper'

describe UsersController do
  it "renders application template" do
    get :show
    response.should render_template "layouts/application"
    response.should render_template 'show'
  end
end
