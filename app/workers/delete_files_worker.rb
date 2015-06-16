class DeleteFilesWorker
  include Sidekiq::Worker

  def perform(filename)
    File.delete(filename) if File.exist?(filename)
  end
end