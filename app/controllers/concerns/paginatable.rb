module Paginatable
    extend ActiveSupport::Concern

    MAX_PER_PAGE = 10
    DEFAULT_PAGE = 1
    
    included do
      scope :paginate, -> (page, length) do
        page = page.to_i
        length = length.to_i
        page = page.present? && page > 0 ? page : DEFAULT_PAGE
        length = length.present? && length > 0 ? length : MAX_PER_PAGE

        offset = (page - 1) * length
        
        self.offset(offset).limit(length)
      end
    end
end