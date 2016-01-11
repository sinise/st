class Admins::ArticlesController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  @@AMZ_ARTICLE_BUCKET = "stressmind.article"

  # GET /articles
  # GET /articles.json
  def index
    @articles = Admins::Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Admins::Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    filename, url = upload_file
    @article = Admins::Article.new(article_params)
    @article.filename = filename
    @article.url = url;
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    filename, url = upload_file
    @article.filename = filename
    @article.url = url;

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    AWS::S3::S3Object.find(@article.filename, @@AMZ_ARTICLE_BUCKET).delete
    @article.destroy
    redirect_to admins_articles_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Admins::Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:admins_article).permit(:name, :abstract, :upload)
    end

    def sanitize_filename(file_name)
      just_filename = File.basename(file_name)
      just_filename.sub(/[^\w\.\-]/,'_')
    end

    def upload_file
      fileUp = params[:upload]
      orig_filename =  fileUp['datafile'].original_filename
      filename = sanitize_filename(orig_filename)
      AWS::S3::S3Object.store(filename, fileUp['datafile'].read, @@AMZ_ARTICLE_BUCKET, :access => :public_read)
      url = AWS::S3::S3Object.url_for(filename, @@AMZ_ARTICLE_BUCKET, :authenticated => false)

      [filename, url]
    end
end
