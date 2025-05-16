{%- macro surrogate_key(field_list) -%}

{%- if varargs|length >= 1 or field_list is string %}

{%- set error_message = '

'.format(model.package_name, model.name) -%}

{%- do exceptions.warn(error_message) -%}

{%- set field_list_xf = [field_list] -%}

{%- for field in varargs %}
{%- set _ = field_list_xf.append(field) -%}
{%- endfor -%}

{%- else -%}

{%- set field_list_xf = field_list -%}

{%- endif -%}


{%- set fields = [] -%}

{%- for field in field_list_xf -%}

    {%- set _ = fields.append(
       "coalesce(cast(" ~ field ~ " as string), '')"
   ) -%}

   {%- if not loop.last %}
       {%- set _ = fields.append("'-'") -%}
   {%- endif -%}

{%- endfor -%}

farm_fingerprint(concat({{ fields | join(', ') }}))

{%- endmacro -%}