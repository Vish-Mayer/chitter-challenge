# frozen_string_literal: true

def data_matcher(what, where)
  data = DatabaseConnection.query("SELECT #{what} FROM #{where}")
  data.map { |selector| selector[what.to_s] }
end
