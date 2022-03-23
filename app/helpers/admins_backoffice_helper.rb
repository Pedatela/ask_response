module AdminsBackofficeHelper
    def translate_attribute(object = nil, attribute = nil)
        object && attribute ? object.model.human_attribute_name(attribute) : "Informe os parametros corretos"
    end
end
