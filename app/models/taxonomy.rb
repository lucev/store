class Taxonomy
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :parent, :class_name => 'Taxonomy', inverse_of: :children
  has_many :children, :class_name => 'Taxonomy', inverse_of: :parent
  has_and_belongs_to_many :ancestors, :class_name => 'Taxonomy', inverse_of: :descendants
  has_and_belongs_to_many :descendants, :class_name => 'Taxonomy', inverse_of: :ancestors

  def indented_name
    ("<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>" * ancestors.count + name).html_safe
  end

  def has_children?
    children.present?
  end

  def get_descendants(array=[])
    array << self unless self.is_root?
    # array << self
    self.children.each do |taxonomy|
      taxonomy.get_descendants(array)
    end
    array
  end

  def is_root?
    self.parent.nil?
  end
end
