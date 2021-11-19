---script dim_tempo versão:20210930
---prof. anderson nascimento
create table dim_data (
sk_data integer not null,
nk_data date not null,
desc_data_completa varchar(60) not null,
nr_ano integer not null,
nm_trimestre varchar(20) not null,
nr_ano_trimestre varchar(20) not null,
nr_mes integer not null,
nm_mes varchar(20) not null,
ano_mes varchar(20) not null,
nr_semana integer not null,
ano_semana varchar(20) not null,
nr_dia integer not null,
nr_dia_ano integer not null,
nm_dia_semana varchar(20) not null,
flag_final_semana char(3) not null,
flag_feriado char(3) not null,
flag_dt_festiva char(3) not null,
dt_festiva varchar(50) not null,
nm_feriado varchar(60) not null,
etl_dt_inicio timestamp not null,
etl_dt_fim timestamp not null,
constraint sk_data_pk primary key (sk_data)
);

insert into dim_data
select to_number(to_char(datum,'yyyymmdd'), '99999999') as sk_tempo,
datum as nk_data,
to_char(datum,'dd/mm/yyyy') as data_completa_formatada,
extract (year from datum) as nr_ano,
'T' || to_char(datum, 'q') as nm_trimestre,
to_char(datum, '"T"q/yyyy') as nr_ano_trimenstre,
extract(month from datum) as nr_mes,
to_char(datum, 'tmMonth') as nm_mes,
to_char(datum, 'yyyy/mm') as nr_ano_nr_mes,
extract(week from datum) as nr_semana,
to_char(datum, 'iyyy/iw') as nr_ano_nr_semana,
extract(day from datum) as nr_dia,
extract(doy from datum) as nr_dia_ano,
to_char(datum, 'tmDay') as nm_dia_semana,
case when extract(isodow from datum) in (6, 7) then 'Sim' else 'Não'
end as flag_final_semana,
case when to_char(datum, 'mmdd') in ('0101','0501','0907','1012','1115','1120','1225', '1031','0624','0712','0308','1128') then 'Sim' else 'Não'
end as flag_feriado,
case when to_char(datum, 'yyyymmdd') in ('20210509''20220508''20230514''20240512''20210808''20220814''20230813''20240811''20210216''20220301''20230221''20240213''20210624''20220624''20230624''20240624') then 'Sim' else 'Não'
end as flag_dt_festiva,
case --incluir datas festivas próximos 4 anos.

when to_char(datum, 'yyyymmdd') = '20210509' then 'Dia das Mães'
when to_char(datum, 'yyyymmdd') = '20220508' then 'Dia das Mães'
when to_char(datum, 'yyyymmdd') = '20230514' then 'Dia das Mães'
when to_char(datum, 'yyyymmdd') = '20240512' then 'Dia das Mães'

when to_char(datum, 'yyyymmdd') = '20210808' then 'Dia dos Pais'
when to_char(datum, 'yyyymmdd') = '20220814' then 'Dia dos Pais'
when to_char(datum, 'yyyymmdd') = '20230813' then 'Dia dos Pais'
when to_char(datum, 'yyyymmdd') = '20240811' then 'Dia dos Pais'

when to_char(datum, 'yyyymmdd') = '20210216' then 'Carnaval'
when to_char(datum, 'yyyymmdd') = '20220301' then 'Carnaval'
when to_char(datum, 'yyyymmdd') = '20230221' then 'Carnaval'
when to_char(datum, 'yyyymmdd') = '20240213' then 'Carnaval'

when to_char(datum, 'mmdd') = '20210624' then 'Festa Junina' 
when to_char(datum, 'mmdd') = '20220624' then 'Festa Junina' 
when to_char(datum, 'mmdd') = '20230624' then 'Festa Junina' 
when to_char(datum, 'mmdd') = '20240624' then 'Festa Junina' 
else 'Não é data festiva'
end as dt_festiva,
case 
---incluir aqui os feriados
when to_char(datum, 'mmdd') = '0101' then 'Ano Novo' 
when to_char(datum, 'mmdd') = '0501' then 'Dia do Trabalhador'
when to_char(datum, 'mmdd') = '0907' then 'Dia da Pátria' 
when to_char(datum, 'mmdd') = '1115' then 'Proclamação da República'
when to_char(datum, 'mmdd') = '1120' then 'Dia da Consciência Negra'
when to_char(datum, 'mmdd') = '1225' then 'Natal'
when to_char(datum, 'mmdd') = '1031' then 'Dia das Bruxas' 
when to_char(datum, 'mmdd') = '1012' then 'Dia das Crianças' 
when to_char(datum, 'mmdd') = '0712' then 'Dia dos Namorados' 
when to_char(datum, 'mmdd') = '0308' then 'Dia da Mulher' 
when to_char(datum, 'mmdd') = '1128' then 'Dia de Ação de Graças' 
else 'Não é Feriado'
end as nm_feriado,
current_timestamp as data_carga,
'2199-12-30'
from (
---incluir aqui a data de início do script, criaremos 15 anos de datas
select '2021-01-01'::date + sequence.day as datum
from generate_series(0,5479) as sequence(day)
group by sequence.day
) dq
order by 1;