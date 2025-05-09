--Usado para configurar a materialização da tabela com o uso incremental
{{ config(
    materialized='incremental'
) }}
------------------------------------------------------
--Consulta principal
with source as (
    select
    *
    from {{ source('ecommerce','pedidos') }}
)

select
*
from source
-------------------------------------------------------------
--Incluindo no modelo a atualização incremental

{% if is_incremental() %}
    where data_pedido >= (select max(data_pedido) from {{ this }})
{% endif %}

