class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    p '-------------------------'
  end
end