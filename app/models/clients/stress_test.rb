class Clients::StressTest
  include Mongoid::Document
  store_in collection: "stress_tests"

  paginates_per 15

  belongs_to :user
  belongs_to :company,       :class_name => 'Admins::Company'
  belongs_to :department,    :class_name => 'Admins::Department'

  field :version,       type: String
  field :results,       type: Hash
  field :pd,            type: Integer  #Test scores
  field :el,            type: Integer  #Test scores
  field :test_result,   type: String
  field :created,       type: Time


  def cal_test_result
  	u_pd = 28
    u_el = 38

    pd, el = get_scores
    self.pd, self.el = pd, el

    if pd >= u_pd && el >= u_el
      self.test_result = "high_stress_high_env" 
    elsif pd >= u_pd && el < u_el
      self.test_result = "high_stress_low_env"
    elsif pd < u_pd && el >= u_el
      self.test_result = "low_stress_high_env"
    elsif pd < u_pd && el < u_el
      self.test_result = "low_stress_low_env"
    end

    self.test_result
  end

  def stressed?
    return self.test_result == "high_stress_high_env" || self.test_result == "high_stress_low_env"
  end

  private
  def get_scores
  	personal_vul_scale = 0
    event_load_scale = 0

    # Ignore responses to Items #1, #6, #11, #16, #21, and #26.
    excl_ques = ["1", "6", "11", "16", "21", "26"]
    self.results.each do |key, value| 
      que = key.delete('q')
      unless excl_ques.include?(que)
        personal_vul_scale += value.to_i if que.to_i.odd?
        event_load_scale   += value.to_i if que.to_i.even?
      end
    end
  	
    [personal_vul_scale, event_load_scale]
  end
end