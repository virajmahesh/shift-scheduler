require 'similar_text'
class SkillsController < ApplicationController

  def order_roles
    input = params[:partial_text]
    roles = Role.pluck(:description) # Returns array of all roles
    ratings = Hash.new # Stores similarity scores

    if input.blank?
      return roles
    end

    roles.each do |role|
      ratings[role] = role.downcase.similar(input.downcase)
    end

    # Sort roles by similarity
    ratings = ratings.sort_by{ |k, v| v }.reverse!.to_h.keys
    render :json => ratings
  end

  def roles
    render :json => Role.all
  end

end