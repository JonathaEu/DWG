
CREATE TABLE public.dim_data (
                sk_data INTEGER NOT NULL,
                nk_data DATE NOT NULL,
                desc_data_completa VARCHAR(60) NOT NULL,
                nr_ano INTEGER NOT NULL,
                nm_trimestre VARCHAR(20) NOT NULL,
                nr_ano_trimestre VARCHAR(20) NOT NULL,
                nr_mes INTEGER NOT NULL,
                nm_mes VARCHAR(20) NOT NULL,
                ano_mes VARCHAR(20) NOT NULL,
                nr_semana INTEGER NOT NULL,
                ano_semana VARCHAR(20) NOT NULL,
                nr_dia INTEGER NOT NULL,
                nr_dia_ano INTEGER NOT NULL,
                nm_dia_semana VARCHAR(20) NOT NULL,
                flag_final_semana CHAR(3) NOT NULL,
                flag_feriado CHAR(3) NOT NULL,
                flag_dt_festiva CHAR(3) NOT NULL,
                dt_festiva VARCHAR(50) NOT NULL,
                nm_feriado VARCHAR(60) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                CONSTRAINT sk_data_pk PRIMARY KEY (sk_data)
);


CREATE SEQUENCE public.dim_produtos_sk_produto_seq;

CREATE TABLE public.dim_produtos (
                sk_produto INTEGER NOT NULL DEFAULT nextval('public.dim_produtos_sk_produto_seq'),
                nk_produto INTEGER NOT NULL,
                tipo_produto VARCHAR(20) NOT NULL,
                etl_versao INTEGER NOT NULL,
                elt_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                CONSTRAINT sk_produto PRIMARY KEY (sk_produto)
);


ALTER SEQUENCE public.dim_produtos_sk_produto_seq OWNED BY public.dim_produtos.sk_produto;

CREATE SEQUENCE public.dim_funcionarios_sk_funcionarios_seq;

CREATE TABLE public.dim_funcionarios (
                sk_funcionarios INTEGER NOT NULL DEFAULT nextval('public.dim_funcionarios_sk_funcionarios_seq'),
                nk_funcionarios INTEGER NOT NULL,
                nome_funcionario VARCHAR(40) NOT NULL,
                num_vendas NUMERIC(10) NOT NULL,
                etl_versao INTEGER NOT NULL,
                elt_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                CONSTRAINT sk_funcionarios PRIMARY KEY (sk_funcionarios)
);


ALTER SEQUENCE public.dim_funcionarios_sk_funcionarios_seq OWNED BY public.dim_funcionarios.sk_funcionarios;

CREATE SEQUENCE public.dim_cliente_sk_cliente_seq;

CREATE TABLE public.dim_cliente (
                sk_cliente INTEGER NOT NULL DEFAULT nextval('public.dim_cliente_sk_cliente_seq'),
                nk_cliente INTEGER NOT NULL,
                nome_cliente VARCHAR(50) NOT NULL,
                idade_cliente NUMERIC(4) NOT NULL,
                etl_versao INTEGER NOT NULL,
                elt_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                CONSTRAINT sk_cliente PRIMARY KEY (sk_cliente)
);


ALTER SEQUENCE public.dim_cliente_sk_cliente_seq OWNED BY public.dim_cliente.sk_cliente;

CREATE TABLE public.ft_vendas (
                sk_produto INTEGER NOT NULL,
                sk_cliente INTEGER NOT NULL,
                sk_funcionarios INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                md_valor_venda REAL NOT NULL,
                dd_codfuncionario INTEGER NOT NULL,
                dd_prod_vendido VARCHAR(20) NOT NULL
);


ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_data_ft_vendas_fk
FOREIGN KEY (sk_data)
REFERENCES public.dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_produto_fato___negocio_fk
FOREIGN KEY (sk_produto)
REFERENCES public.dim_produtos (sk_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_funcionarios_fato___negocio_fk
FOREIGN KEY (sk_funcionarios)
REFERENCES public.dim_funcionarios (sk_funcionarios)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_vendas ADD CONSTRAINT dim_cliente_fato___negocio_fk
FOREIGN KEY (sk_cliente)
REFERENCES public.dim_cliente (sk_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;