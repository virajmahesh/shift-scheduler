require 'similar_text'
class RolesController < ApplicationController
    def orderRoles
        inp = params[:partial_text]
        roles = Role.pluck(:description) #Returns array of all roles
        ratings = Hash.new #Stores Role: Similarity score
        
        if inp.blank?
            return roles
        end
        
        roles.each { |role|
            ratings[role] = role.downcase.similar(inp.downcase)
        }
        
        ratings = ratings.sort_by{|_key, value| value}.reverse!.to_h.keys #Sort roles by similarity score.
        render :json => ratings
    end
end