class WelcomeController < ApplicationController
  def index
    @posts = Post.last(6)
  end
end
