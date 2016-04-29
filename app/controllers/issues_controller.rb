class IssuesController < ApplicationController

  # Return a JSON list of all issues in the DB
  def index
    render :json => Issue.all
  end

end
