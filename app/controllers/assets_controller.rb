class AssetsController < ApplicationController
  def index
    inject_flash_messages
  end

  def inject_flash_messages
    gon.push(flash.to_hash)
  end
end
