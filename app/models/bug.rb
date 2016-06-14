class Bug < ActiveRecord::Base
  belongs_to :software_ver, class_name: 'Dropdown'
  belongs_to :service, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  
  has_many :watches, as: :object
  has_many :bug_notes
  
  def status
    if self.solution.present?
      'Solved'
    elsif self.workaround.present?
      'Workaround'
    else
      'Open'
    end
  end
end
