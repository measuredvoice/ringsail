# encoding: utf-8
class GobiernoController < OutletsController
  layout "gobierno"
  
  def verify
    @errors ||= {};
    @errors[:bad_service_url] = " Lo sentimos pero no podemos buscar el URL que proporcionó debido a que no es parte de los servicios de redes sociales que podemos verificar.";
    @errors[:bad_account] = " TODO: translate this account error.";
    @errors[:help_msg] = "";
    super
  end
end