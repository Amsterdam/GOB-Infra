-- Create schemas for GOB
create schema bag;
create schema brk;
create schema bgt;
create schema gebieden;
create schema meetbouten;
create schema nap;
create schema wkpb;

CREATE OR REPLACE FUNCTION public.on_create_table_or_view_func()
 RETURNS event_trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_ddl_commands() WHERE command_tag in ('SELECT INTO','CREATE TABLE','CREATE TABLE AS','CREATE VIEW')
  LOOP
        if obj.schema_name = 'maatwerkbasisinformatie'
        then
        execute 'grant select ON ' || obj.object_identity || ' to maatwerkbasisinformatie_read';
        end if;
  END LOOP;
END;
$function$;

DROP EVENT TRIGGER IF EXISTS on_create_table_or_view;

CREATE EVENT TRIGGER
on_create_table_or_view ON ddl_command_end
WHEN TAG IN ('CREATE TABLE','CREATE VIEW', 'SELECT INTO', 'CREATE TABLE AS')
EXECUTE PROCEDURE on_create_table_or_view_func();

-- Create work schema for basinformatie
create schema maatwerkbasisinformatie;

-- Creates default read role for given schema and assigns read rights to read role
CREATE OR REPLACE FUNCTION public.create_default_read_role_for_schema(schema varchar)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    read_role varchar := schema || '_read';
BEGIN
    execute 'create role ' || read_role;
    execute 'grant usage on schema ' || schema || ' to ' || read_role;
    execute 'grant select on all tables in schema ' || schema || ' to ' || read_role;
    execute 'alter default privileges in schema ' || schema || ' grant select on tables to ' || read_role;
END;
$function$;

-- Create default read roles to schemas
select create_default_read_role_for_schema('bag'),
       create_default_read_role_for_schema('brk'),
       create_default_read_role_for_schema('bgt'),
       create_default_read_role_for_schema('gebieden'),
       create_default_read_role_for_schema('meetbouten'),
       create_default_read_role_for_schema('nap'),
       create_default_read_role_for_schema('wkpb'),
       create_default_read_role_for_schema('maatwerkbasisinformatie')
;

-- Create maatwerkbasisinformatie_write role
create role maatwerkbasisinformatie_write;
grant usage on schema maatwerkbasisinformatie to maatwerkbasisinformatie_write;
grant all on schema maatwerkbasisinformatie to maatwerkbasisinformatie_write;

-- Create agm_basis role (read all schemas except BRK)
create role agm_basis;
grant bag_read, gebieden_read, wkpb_read, nap_read, meetbouten_read, bgt_read, maatwerkbasisinformatie_read TO agm_basis;

-- Create agm_plus role (read BRK and write to maatwerkbasisinformatie schema)
create role agm_plus;
grant brk_read, maatwerkbasisinformatie_write to agm_plus;
