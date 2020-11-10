class TagAssociationsController < ApplicationController
  private
  def tag_association_params
    params.require(:tag_association).permit( :tag_ids )
  end
end
