ActiveAdmin.register Plan do

  filter :name
  filter :active
  filter :created_at
  filter :updated_at

  index do
    column :name
    column :active
    column :updated_at
    column do |plan|
      action_links(plan)
    end
  end

  form do |f|
    f.inputs "Plan" do
      f.input :name
      f.input :cost
      f.input :active
    end
    f.buttons
  end

  show do |plan|
    attributes_table do
      row :name
      row :cost
      row :active
      row :created_at
      row :updated_at
    end
  end

  controller do
    def create
      @plan = Plan.new(params[:plan])

      if @plan.save
        redirect_to admin_plan_path(@plan)
      else
        render :new
      end
    end

    def update
      @plan = Plan.find(params[:id])

      if @plan.update_attributes(params[:plan])
        redirect_to admin_plan_path(@plan)
      else
        render :edit
      end
    end
  end
end

def action_links(plan)
  links = link_to("View", [:admin, plan]) + " " +
  link_to("Edit", [:edit, :admin, plan]) + " " +
  link_to("Delete", [:admin, plan], method: :delete, data: { confirm: "Are you sure you want to delete this?" })

  raw links
end