module StaticPagesHelper
  include Pagy::Frontend
  
  def status_class(current_status)
    current_status.current_status == 'UP' ? 'alert-success' : 'alert-danger'
  end
end
