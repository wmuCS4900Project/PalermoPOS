class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_many :caps
  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

 def has_cap?(action, object)
    caps = Cap.where(:role_id => self.id, :action => [action, 'all'], :object => [object, 'all'])
    # If not blank, has cap
    return !caps.blank?
  end
end
