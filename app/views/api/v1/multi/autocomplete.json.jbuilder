json.text params[:q]
json.agencies @agencies, :id, :name 
json.services @services, :shortname, :longname
json.tags @tags, :id, :tag_text