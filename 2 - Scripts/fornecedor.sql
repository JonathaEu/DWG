CREATE TABLE public.fornecedor
(
	CNPJ numeric(20,0) NOT NULL,
	valor_compra real,
	data_compra date,
	CONSTRAINT fornecedor_pkey PRIMARY KEY (CNPJ)
)
TABLESPACE pg_default;

ALTER TABLE public.fornecedor
    OWNER to postgres;