class InvitationsController < ApplicationController
  before_action :set_invitation, only:  [:show, :edit, :update, :destroy]

  # GET /invitations
  def index
    @title = t('view.invitations.index_title')
    @invitations = Invitation.all.page(params[:page])
  end

  # GET /invitations/1
  def show
    @title = t('view.invitations.show_title')
  end

  # GET /invitations/new
  def new
    @title = t('view.invitations.new_title')
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
    @title = t('view.invitations.edit_title')
  end

  # POST /invitations
  def create
    @title = t('view.invitations.new_title')
    @invitation = Invitation.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: t('view.invitations.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /invitations/1
  def update
    @title = t('view.invitations.edit_title')

    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: t('view.invitations.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_invitation_url(@invitation), alert: t('view.invitations.stale_object_error')
  end

  # DELETE /invitations/1
  def destroy
    @invitation.destroy
    redirect_to invitations_url, notice: t('view.invitations.correctly_destroyed')
  end

  private

    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    def invitation_params
      params.require(:invitation).permit(:group_id, :user_id)
    end
end
