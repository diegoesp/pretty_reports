ActiveAdmin.register User do

  filter :email
  filter :created_at
  filter :updated_at

  index do
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :updated_at
    column do |user|
      action_links(user)
    end
  end

  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin
    end
    f.buttons
  end

  show do |user|
    attributes_table do
      row :email
      row :created_at
      row :updated_at
      row :admin
    end
  end

  controller do
    def create
      @user = User.new(params[:user].except(:admin, :project_ids))

      @user.admin = params[:user][:admin] if params[:user][:admin]
      if @user.save
        redirect_to admin_user_path(@user)
      else
        render :new
      end
    end

    def update
      @user = User.find(params[:id])

      @user.admin = params[:user][:admin] if params[:user][:admin]

      except_attrs = [:admin]

      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        except_attrs << :password << :password_confirmation
      end

      if @user.update_attributes(params[:user].except(*except_attrs))
        redirect_to admin_user_path(@user)
      else
        render :edit
      end
    end
  end
end

def action_links(user)
  links = link_to("View", [:admin, user]) + " " +
  link_to("Edit", [:edit, :admin, user]) + " " +
  unless user == current_user
    link_to("Delete", [:admin, user], method: :delete, data: { confirm: "Are you sure you want to delete this?" })
  end
  raw links
end