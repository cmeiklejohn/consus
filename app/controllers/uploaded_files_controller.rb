class UploadedFilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @files = StorageClient.new(current_user.email).files
  end

  def show
    filename = "#{params[:id]}.#{params[:format]}"
    @file = StorageClient.new(current_user.email).file(filename)
    send_data(@file.body, :filename => filename, :type => @file.content_type)
  end

  def new; end

  def create
    StorageClient.new(current_user.email).create_file(
      params[:uploaded_file][:name], params[:uploaded_file][:body]
    )

    flash[:notice] = "File uploaded!"
    redirect_to root_path
  end
end
