ActiveAdmin.register Report do

  filter :user
  filter :created_at
  filter :updated_at

  index do
    column :title
    column :user
    column :report_type
    column :created_at
    column :updated_at
    column do |report|
      action_links(report)
    end
  end

  form do |f|
    f.inputs "Report" do
      f.input :title
      f.input :subtitle
      f.input :report_type
      f.input :user
    end
    f.buttons
  end

  show do |report|
    attributes_table do
      row :title
      row :subtitle
      row :report_type
      row :user
      row :created_at
      row :updated_at
    end
  end

  controller do
    def create
      @report = Report.new(params[:report])

      if @report.save
        redirect_to admin_report_path(@report)
      else
        render :new
      end
    end

    def update
      @report = Report.find(params[:id])

      if @report.update_attributes(params[:report])
        redirect_to admin_report_path(@report)
      else
        render :edit
      end
    end
  end
end

def action_links(report)
  links = link_to("View", [:admin, report]) + " " +
  link_to("Edit", [:edit, :admin, report]) + " " +
  link_to("Delete", [:admin, report], method: :delete, data: { confirm: "Are you sure you want to delete this?" })

  raw links
end