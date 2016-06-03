class ListItemsController < ApplicationController


  def create
    @list_item = ListItem.create(list_item_params)
    current_user.list_items << @list_item
    respond_to do |format|
      format.json  { render :json => @list_item }
    end
  end

  private

  def list_item_params
    params.require(:list_item).permit(:content)
  end
end
