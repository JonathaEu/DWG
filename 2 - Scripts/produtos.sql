-- Table: public.produtos

-- DROP TABLE public.produtos;

CREATE TABLE IF NOT EXISTS public.produtos
(
    codprodutos integer NOT NULL,
    tipo_produto character varying(20) COLLATE pg_catalog."default",
    cnpj numeric(20,0),
    foreign key (cnpj) references fornecedor(cnpj),
    CONSTRAINT produtos_pkey PRIMARY KEY (codprodutos)
    
)

TABLESPACE pg_default;

ALTER TABLE public.produtos
    OWNER to postgres;