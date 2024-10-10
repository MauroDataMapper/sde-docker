--
-- PostgreSQL database dump
--

\c maurodatamapper

-- Dumped from database version 12.14
-- Dumped by pg_dump version 12.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: core; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA core;


ALTER SCHEMA core OWNER TO maurodatamapperuser;

--
-- Name: dataflow; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA dataflow;


ALTER SCHEMA dataflow OWNER TO maurodatamapperuser;

--
-- Name: datamodel; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA datamodel;


ALTER SCHEMA datamodel OWNER TO maurodatamapperuser;

--
-- Name: federation; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA federation;


ALTER SCHEMA federation OWNER TO maurodatamapperuser;

--
-- Name: migration; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA migration;


ALTER SCHEMA migration OWNER TO maurodatamapperuser;

--
-- Name: openidconnect; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA openidconnect;


ALTER SCHEMA openidconnect OWNER TO maurodatamapperuser;

--
-- Name: referencedata; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA referencedata;


ALTER SCHEMA referencedata OWNER TO maurodatamapperuser;

--
-- Name: security; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA security;


ALTER SCHEMA security OWNER TO maurodatamapperuser;

--
-- Name: terminology; Type: SCHEMA; Schema: -; Owner: maurodatamapperuser
--

CREATE SCHEMA terminology;


ALTER SCHEMA terminology OWNER TO maurodatamapperuser;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: annotation; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.annotation (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    parent_annotation_id uuid,
    created_by character varying(255) NOT NULL,
    label text NOT NULL,
    description text,
    child_annotations_idx integer
);


ALTER TABLE core.annotation OWNER TO maurodatamapperuser;

--
-- Name: api_property; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.api_property (
    id uuid NOT NULL,
    version bigint NOT NULL,
    last_updated_by character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    value text NOT NULL,
    created_by character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    publicly_visible boolean DEFAULT false NOT NULL,
    category character varying(255),
    path text NOT NULL
);


ALTER TABLE core.api_property OWNER TO maurodatamapperuser;

--
-- Name: async_job; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.async_job (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text,
    started_by_user character varying(255) NOT NULL,
    date_time_started timestamp without time zone NOT NULL,
    job_name character varying(255) NOT NULL,
    created_by character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    message text
);


ALTER TABLE core.async_job OWNER TO maurodatamapperuser;

--
-- Name: authority; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.authority (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    url character varying(255) NOT NULL,
    created_by character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    label text NOT NULL,
    description text,
    default_authority boolean DEFAULT false NOT NULL,
    path text NOT NULL
);


ALTER TABLE core.authority OWNER TO maurodatamapperuser;

--
-- Name: breadcrumb_tree; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.breadcrumb_tree (
    id uuid NOT NULL,
    version bigint NOT NULL,
    domain_type character varying(255) NOT NULL,
    finalised boolean,
    domain_id uuid,
    tree_string text NOT NULL,
    top_breadcrumb_tree boolean NOT NULL,
    label text,
    parent_id uuid,
    path text
);


ALTER TABLE core.breadcrumb_tree OWNER TO maurodatamapperuser;

--
-- Name: classifier; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.classifier (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    parent_classifier_id uuid,
    readable_by_authenticated_users boolean NOT NULL,
    created_by character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE core.classifier OWNER TO maurodatamapperuser;

--
-- Name: domain_export; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.domain_export (
    id uuid NOT NULL,
    version bigint NOT NULL,
    multi_domain_export boolean NOT NULL,
    date_created timestamp without time zone NOT NULL,
    exporter_namespace character varying(255) NOT NULL,
    export_file_name character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text,
    exported_domain_ids character varying(255),
    exported_domain_type character varying(255) NOT NULL,
    exporter_name character varying(255) NOT NULL,
    exported_domain_id uuid,
    export_data bytea NOT NULL,
    created_by character varying(255) NOT NULL,
    exporter_version character varying(255) NOT NULL,
    export_content_type character varying(255) NOT NULL
);


ALTER TABLE core.domain_export OWNER TO maurodatamapperuser;

--
-- Name: edit; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.edit (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    resource_domain_type character varying(255) NOT NULL,
    resource_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    description text NOT NULL,
    title character varying(255) NOT NULL,
    path text NOT NULL
);


ALTER TABLE core.edit OWNER TO maurodatamapperuser;

--
-- Name: email; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.email (
    id uuid NOT NULL,
    version bigint NOT NULL,
    sent_to_email_address character varying(255) NOT NULL,
    successfully_sent boolean NOT NULL,
    body text NOT NULL,
    date_time_sent timestamp without time zone,
    email_service_used character varying(255),
    failure_reason text,
    subject text NOT NULL
);


ALTER TABLE core.email OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE core.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: folder; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.folder (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    deleted boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    parent_folder_id uuid,
    created_by character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    label text NOT NULL,
    description text,
    class character varying(255) DEFAULT 'uk.ac.ox.softeng.maurodatamapper.core.container.Folder'::character varying NOT NULL,
    branch_name character varying(255),
    finalised boolean,
    date_finalised timestamp without time zone,
    documentation_version character varying(255),
    model_version character varying(255),
    authority_id uuid,
    model_version_tag character varying(255)
);


ALTER TABLE core.folder OWNER TO maurodatamapperuser;

--
-- Name: image_file; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.image_file (
    id uuid NOT NULL,
    version bigint NOT NULL,
    file_size bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    file_type character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    user_id uuid,
    file_contents bytea NOT NULL,
    created_by character varying(255) NOT NULL,
    path text NOT NULL,
    class character varying(255) DEFAULT 'uk.ac.ox.softeng.maurodatamapper.core.file.ImageFile'::character varying NOT NULL
);


ALTER TABLE core.image_file OWNER TO maurodatamapperuser;

--
-- Name: join_classifier_to_facet; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.join_classifier_to_facet (
    classifier_id uuid NOT NULL,
    annotation_id uuid,
    rule_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid
);


ALTER TABLE core.join_classifier_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_folder_to_facet; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.join_folder_to_facet (
    folder_id uuid NOT NULL,
    annotation_id uuid,
    rule_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid
);


ALTER TABLE core.join_folder_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_versionedfolder_to_facet; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.join_versionedfolder_to_facet (
    versionedfolder_id uuid NOT NULL,
    version_link_id uuid
);


ALTER TABLE core.join_versionedfolder_to_facet OWNER TO maurodatamapperuser;

--
-- Name: metadata; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.metadata (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    namespace text NOT NULL,
    multi_facet_aware_item_id uuid,
    value text NOT NULL,
    created_by character varying(255) NOT NULL,
    key text NOT NULL,
    path text NOT NULL
);


ALTER TABLE core.metadata OWNER TO maurodatamapperuser;

--
-- Name: reference_file; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.reference_file (
    id uuid NOT NULL,
    version bigint NOT NULL,
    file_size bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    file_type character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    file_contents bytea NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    path text NOT NULL
);


ALTER TABLE core.reference_file OWNER TO maurodatamapperuser;

--
-- Name: rule; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.rule (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    name text,
    created_by character varying(255) NOT NULL,
    description text,
    path text NOT NULL
);


ALTER TABLE core.rule OWNER TO maurodatamapperuser;

--
-- Name: rule_representation; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.rule_representation (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    rule_id uuid NOT NULL,
    language text NOT NULL,
    representation text NOT NULL,
    created_by character varying(255) NOT NULL,
    path text NOT NULL
);


ALTER TABLE core.rule_representation OWNER TO maurodatamapperuser;

--
-- Name: semantic_link; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.semantic_link (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    target_multi_facet_aware_item_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    target_multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    link_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    unconfirmed boolean DEFAULT false NOT NULL,
    path text NOT NULL
);


ALTER TABLE core.semantic_link OWNER TO maurodatamapperuser;

--
-- Name: version_link; Type: TABLE; Schema: core; Owner: maurodatamapperuser
--

CREATE TABLE core.version_link (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    target_model_domain_type character varying(255) NOT NULL,
    link_type character varying(255) NOT NULL,
    target_model_id uuid NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    path text NOT NULL
);


ALTER TABLE core.version_link OWNER TO maurodatamapperuser;

--
-- Name: data_class_component; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.data_class_component (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    data_flow_id uuid NOT NULL,
    definition text,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE dataflow.data_class_component OWNER TO maurodatamapperuser;

--
-- Name: data_element_component; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.data_element_component (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    data_class_component_id uuid NOT NULL,
    definition text,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE dataflow.data_element_component OWNER TO maurodatamapperuser;

--
-- Name: data_flow; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.data_flow (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    definition text,
    diagram_layout text,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    source_id uuid NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    target_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE dataflow.data_flow OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE dataflow.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: join_data_class_component_to_source_data_class; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.join_data_class_component_to_source_data_class (
    data_class_component_id uuid NOT NULL,
    data_class_id uuid
);


ALTER TABLE dataflow.join_data_class_component_to_source_data_class OWNER TO maurodatamapperuser;

--
-- Name: join_data_class_component_to_target_data_class; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.join_data_class_component_to_target_data_class (
    data_class_component_id uuid NOT NULL,
    data_class_id uuid
);


ALTER TABLE dataflow.join_data_class_component_to_target_data_class OWNER TO maurodatamapperuser;

--
-- Name: join_data_element_component_to_source_data_element; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.join_data_element_component_to_source_data_element (
    data_element_component_id uuid NOT NULL,
    data_element_id uuid
);


ALTER TABLE dataflow.join_data_element_component_to_source_data_element OWNER TO maurodatamapperuser;

--
-- Name: join_data_element_component_to_target_data_element; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.join_data_element_component_to_target_data_element (
    data_element_component_id uuid NOT NULL,
    data_element_id uuid
);


ALTER TABLE dataflow.join_data_element_component_to_target_data_element OWNER TO maurodatamapperuser;

--
-- Name: join_dataclasscomponent_to_facet; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.join_dataclasscomponent_to_facet (
    dataclasscomponent_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE dataflow.join_dataclasscomponent_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_dataelementcomponent_to_facet; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.join_dataelementcomponent_to_facet (
    dataelementcomponent_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE dataflow.join_dataelementcomponent_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_dataflow_to_facet; Type: TABLE; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE TABLE dataflow.join_dataflow_to_facet (
    dataflow_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE dataflow.join_dataflow_to_facet OWNER TO maurodatamapperuser;

--
-- Name: data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.data_class (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    min_multiplicity integer,
    max_multiplicity integer,
    parent_data_class_id uuid,
    breadcrumb_tree_id uuid NOT NULL,
    data_model_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE datamodel.data_class OWNER TO maurodatamapperuser;

--
-- Name: data_element; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.data_element (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    data_class_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    min_multiplicity integer,
    max_multiplicity integer,
    breadcrumb_tree_id uuid NOT NULL,
    data_type_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE datamodel.data_element OWNER TO maurodatamapperuser;

--
-- Name: data_model; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.data_model (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid NOT NULL,
    folder_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    authority_id uuid,
    branch_name character varying(255),
    model_version character varying(255),
    model_version_tag character varying(255),
    path text NOT NULL
);


ALTER TABLE datamodel.data_model OWNER TO maurodatamapperuser;

--
-- Name: data_type; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.data_type (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    domain_type character varying(15) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    data_model_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    class character varying(255) NOT NULL,
    units character varying(255),
    reference_class_id uuid,
    model_resource_id uuid,
    model_resource_domain_type character varying(255)
);


ALTER TABLE datamodel.data_type OWNER TO maurodatamapperuser;

--
-- Name: enumeration_value; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.enumeration_value (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    enumeration_type_id uuid NOT NULL,
    value text NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    category text,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    key text NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE datamodel.enumeration_value OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE datamodel.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: join_dataclass_to_extended_data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_dataclass_to_extended_data_class (
    dataclass_id uuid NOT NULL,
    extended_dataclass_id uuid NOT NULL
);


ALTER TABLE datamodel.join_dataclass_to_extended_data_class OWNER TO maurodatamapperuser;

--
-- Name: join_dataclass_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_dataclass_to_facet (
    dataclass_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_dataclass_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_dataclass_to_imported_data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_dataclass_to_imported_data_class (
    imported_dataclass_id uuid NOT NULL,
    dataclass_id uuid NOT NULL
);


ALTER TABLE datamodel.join_dataclass_to_imported_data_class OWNER TO maurodatamapperuser;

--
-- Name: join_dataclass_to_imported_data_element; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_dataclass_to_imported_data_element (
    dataclass_id uuid NOT NULL,
    imported_dataelement_id uuid NOT NULL
);


ALTER TABLE datamodel.join_dataclass_to_imported_data_element OWNER TO maurodatamapperuser;

--
-- Name: join_dataelement_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_dataelement_to_facet (
    dataelement_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_dataelement_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_datamodel_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_datamodel_to_facet (
    datamodel_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_datamodel_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_datamodel_to_imported_data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_datamodel_to_imported_data_class (
    imported_dataclass_id uuid NOT NULL,
    datamodel_id uuid NOT NULL
);


ALTER TABLE datamodel.join_datamodel_to_imported_data_class OWNER TO maurodatamapperuser;

--
-- Name: join_datamodel_to_imported_data_type; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_datamodel_to_imported_data_type (
    imported_datatype_id uuid NOT NULL,
    datamodel_id uuid NOT NULL
);


ALTER TABLE datamodel.join_datamodel_to_imported_data_type OWNER TO maurodatamapperuser;

--
-- Name: join_datatype_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_datatype_to_facet (
    datatype_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_datatype_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_enumerationvalue_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.join_enumerationvalue_to_facet (
    enumerationvalue_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_enumerationvalue_to_facet OWNER TO maurodatamapperuser;

--
-- Name: summary_metadata; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.summary_metadata (
    id uuid NOT NULL,
    version bigint NOT NULL,
    summary_metadata_type character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    label text NOT NULL,
    description text,
    path text NOT NULL
);


ALTER TABLE datamodel.summary_metadata OWNER TO maurodatamapperuser;

--
-- Name: summary_metadata_report; Type: TABLE; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE TABLE datamodel.summary_metadata_report (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    report_date timestamp without time zone NOT NULL,
    created_by character varying(255) NOT NULL,
    report_value text NOT NULL,
    summary_metadata_id uuid NOT NULL,
    path text NOT NULL
);


ALTER TABLE datamodel.summary_metadata_report OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: federation; Owner: maurodatamapperuser
--

CREATE TABLE federation.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE federation.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: subscribed_catalogue; Type: TABLE; Schema: federation; Owner: maurodatamapperuser
--

CREATE TABLE federation.subscribed_catalogue (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    readable_by_everyone boolean NOT NULL,
    created_by character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    refresh_period integer,
    label text NOT NULL,
    description text,
    last_read timestamp without time zone,
    connection_timeout integer,
    path text,
    subscribed_catalogue_type character varying(255) DEFAULT 'MAURO_JSON'::character varying NOT NULL,
    subscribed_catalogue_authentication_type character varying(255) DEFAULT 'NO_AUTHENTICATION'::character varying NOT NULL
);


ALTER TABLE federation.subscribed_catalogue OWNER TO maurodatamapperuser;

--
-- Name: subscribed_catalogue_authentication_credentials; Type: TABLE; Schema: federation; Owner: maurodatamapperuser
--

CREATE TABLE federation.subscribed_catalogue_authentication_credentials (
    id uuid NOT NULL,
    version bigint NOT NULL,
    subscribed_catalogue_id uuid NOT NULL,
    api_key text,
    token_url text,
    client_id text,
    client_secret text,
    access_token text,
    access_token_expiry_time timestamp without time zone,
    class character varying(255) NOT NULL
);


ALTER TABLE federation.subscribed_catalogue_authentication_credentials OWNER TO maurodatamapperuser;

--
-- Name: subscribed_model; Type: TABLE; Schema: federation; Owner: maurodatamapperuser
--

CREATE TABLE federation.subscribed_model (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    readable_by_everyone boolean NOT NULL,
    created_by character varying(255) NOT NULL,
    subscribed_catalogue_id uuid NOT NULL,
    subscribed_model_id text NOT NULL,
    subscribed_model_type character varying(255),
    folder_id uuid NOT NULL,
    last_read timestamp without time zone,
    local_model_id uuid,
    path text
);


ALTER TABLE federation.subscribed_model OWNER TO maurodatamapperuser;

--
-- Name: authorization_endpoint_parameters; Type: TABLE; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE TABLE openidconnect.authorization_endpoint_parameters (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    ui_locales character varying(255),
    display character varying(255),
    prompt character varying(255),
    scope character varying(255) NOT NULL,
    acr_values character varying(255),
    id_token_hint character varying(255),
    login_hint character varying(255),
    max_age bigint,
    created_by character varying(255) NOT NULL,
    response_type character varying(255) NOT NULL,
    response_mode character varying(255),
    path text
);


ALTER TABLE openidconnect.authorization_endpoint_parameters OWNER TO maurodatamapperuser;

--
-- Name: discovery_document; Type: TABLE; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE TABLE openidconnect.discovery_document (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    token_endpoint character varying(255) NOT NULL,
    end_session_endpoint character varying(255),
    userinfo_endpoint character varying(255),
    created_by character varying(255) NOT NULL,
    authorization_endpoint character varying(255) NOT NULL,
    jwks_uri character varying(255) NOT NULL,
    issuer character varying(255) NOT NULL,
    path text
);


ALTER TABLE openidconnect.discovery_document OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE TABLE openidconnect.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE openidconnect.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: openid_connect_provider; Type: TABLE; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE TABLE openidconnect.openid_connect_provider (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    discovery_document_url character varying(255),
    authorization_endpoint_parameters_id uuid NOT NULL,
    client_id character varying(255) NOT NULL,
    client_secret character varying(255) NOT NULL,
    discovery_document_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    standard_provider boolean NOT NULL,
    label character varying(255) NOT NULL,
    image_url character varying(255),
    path text
);


ALTER TABLE openidconnect.openid_connect_provider OWNER TO maurodatamapperuser;

--
-- Name: openid_connect_token; Type: TABLE; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE TABLE openidconnect.openid_connect_token (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    expires_in bigint NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    access_token text NOT NULL,
    not_before_policy integer,
    session_id character varying(255) NOT NULL,
    token_type character varying(255) NOT NULL,
    catalogue_user_id uuid NOT NULL,
    session_state character varying(255),
    scope character varying(255) NOT NULL,
    refresh_token text,
    openid_connect_provider_id uuid NOT NULL,
    id_token text NOT NULL,
    created_by character varying(255) NOT NULL,
    refresh_expires_in bigint,
    path text
);


ALTER TABLE openidconnect.openid_connect_token OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE referencedata.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: join_referencedataelement_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.join_referencedataelement_to_facet (
    referencedataelement_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    reference_summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referencedataelement_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_referencedatamodel_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.join_referencedatamodel_to_facet (
    referencedatamodel_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    reference_summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referencedatamodel_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_referencedatatype_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.join_referencedatatype_to_facet (
    referencedatatype_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    reference_summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referencedatatype_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_referenceenumerationvalue_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.join_referenceenumerationvalue_to_facet (
    referenceenumerationvalue_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referenceenumerationvalue_to_facet OWNER TO maurodatamapperuser;

--
-- Name: reference_data_element; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.reference_data_element (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    reference_data_type_id uuid NOT NULL,
    reference_data_model_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    min_multiplicity integer,
    max_multiplicity integer,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    column_number bigint NOT NULL
);


ALTER TABLE referencedata.reference_data_element OWNER TO maurodatamapperuser;

--
-- Name: reference_data_model; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.reference_data_model (
    id uuid NOT NULL,
    version bigint NOT NULL,
    branch_name character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid NOT NULL,
    model_version character varying(255),
    folder_id uuid NOT NULL,
    authority_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    model_version_tag character varying(255),
    path text NOT NULL
);


ALTER TABLE referencedata.reference_data_model OWNER TO maurodatamapperuser;

--
-- Name: reference_data_type; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.reference_data_type (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    reference_data_model_id uuid NOT NULL,
    domain_type character varying(30) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    class character varying(255) NOT NULL,
    units character varying(255)
);


ALTER TABLE referencedata.reference_data_type OWNER TO maurodatamapperuser;

--
-- Name: reference_data_value; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.reference_data_value (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    value text,
    reference_data_model_id uuid NOT NULL,
    reference_data_element_id uuid NOT NULL,
    row_number bigint NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    created_by character varying(255) NOT NULL,
    path text NOT NULL
);


ALTER TABLE referencedata.reference_data_value OWNER TO maurodatamapperuser;

--
-- Name: reference_enumeration_value; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.reference_enumeration_value (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    value text NOT NULL,
    reference_enumeration_type_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    category text,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    key text NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE referencedata.reference_enumeration_value OWNER TO maurodatamapperuser;

--
-- Name: reference_summary_metadata; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.reference_summary_metadata (
    id uuid NOT NULL,
    version bigint NOT NULL,
    summary_metadata_type character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    label text NOT NULL,
    description text,
    path text NOT NULL
);


ALTER TABLE referencedata.reference_summary_metadata OWNER TO maurodatamapperuser;

--
-- Name: reference_summary_metadata_report; Type: TABLE; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE TABLE referencedata.reference_summary_metadata_report (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    report_date timestamp without time zone NOT NULL,
    created_by character varying(255) NOT NULL,
    report_value text NOT NULL,
    summary_metadata_id uuid NOT NULL,
    path text NOT NULL
);


ALTER TABLE referencedata.reference_summary_metadata_report OWNER TO maurodatamapperuser;

--
-- Name: api_key; Type: TABLE; Schema: security; Owner: maurodatamapperuser
--

CREATE TABLE security.api_key (
    id uuid NOT NULL,
    version bigint NOT NULL,
    refreshable boolean NOT NULL,
    date_created timestamp without time zone NOT NULL,
    expiry_date date NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    disabled boolean NOT NULL,
    catalogue_user_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_by character varying(255) NOT NULL,
    path text
);


ALTER TABLE security.api_key OWNER TO maurodatamapperuser;

--
-- Name: catalogue_user; Type: TABLE; Schema: security; Owner: maurodatamapperuser
--

CREATE TABLE security.catalogue_user (
    id uuid NOT NULL,
    version bigint NOT NULL,
    pending boolean NOT NULL,
    salt bytea NOT NULL,
    date_created timestamp without time zone NOT NULL,
    first_name character varying(255) NOT NULL,
    profile_picture_id uuid,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    reset_token uuid,
    disabled boolean NOT NULL,
    job_title character varying(255),
    email_address character varying(255) NOT NULL,
    user_preferences text,
    password bytea,
    created_by character varying(255) NOT NULL,
    temp_password character varying(255),
    last_name character varying(255) NOT NULL,
    last_login timestamp without time zone,
    creation_method character varying(255) NOT NULL,
    path text NOT NULL
);


ALTER TABLE security.catalogue_user OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: security; Owner: maurodatamapperuser
--

CREATE TABLE security.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE security.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: group_role; Type: TABLE; Schema: security; Owner: maurodatamapperuser
--

CREATE TABLE security.group_role (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    display_name character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    parent_id uuid,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    application_level_role boolean NOT NULL,
    created_by character varying(255) NOT NULL
);


ALTER TABLE security.group_role OWNER TO maurodatamapperuser;

--
-- Name: join_catalogue_user_to_user_group; Type: TABLE; Schema: security; Owner: maurodatamapperuser
--

CREATE TABLE security.join_catalogue_user_to_user_group (
    catalogue_user_id uuid NOT NULL,
    user_group_id uuid NOT NULL
);


ALTER TABLE security.join_catalogue_user_to_user_group OWNER TO maurodatamapperuser;

--
-- Name: securable_resource_group_role; Type: TABLE; Schema: security; Owner: maurodatamapperuser
--

CREATE TABLE security.securable_resource_group_role (
    id uuid NOT NULL,
    version bigint NOT NULL,
    securable_resource_id uuid NOT NULL,
    user_group_id uuid NOT NULL,
    date_created timestamp without time zone NOT NULL,
    securable_resource_domain_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    group_role_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    path text
);


ALTER TABLE security.securable_resource_group_role OWNER TO maurodatamapperuser;

--
-- Name: user_group; Type: TABLE; Schema: security; Owner: maurodatamapperuser
--

CREATE TABLE security.user_group (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    application_group_role_id uuid,
    created_by character varying(255) NOT NULL,
    description character varying(255),
    undeleteable boolean DEFAULT false,
    path text NOT NULL
);


ALTER TABLE security.user_group OWNER TO maurodatamapperuser;

--
-- Name: code_set; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.code_set (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid,
    folder_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    authority_id uuid,
    branch_name character varying(255),
    model_version character varying(255),
    model_version_tag character varying(255),
    path text NOT NULL
);


ALTER TABLE terminology.code_set OWNER TO maurodatamapperuser;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE terminology.flyway_schema_history OWNER TO maurodatamapperuser;

--
-- Name: join_codeset_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.join_codeset_to_facet (
    codeset_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_codeset_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_codeset_to_term; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.join_codeset_to_term (
    term_id uuid NOT NULL,
    codeset_id uuid NOT NULL
);


ALTER TABLE terminology.join_codeset_to_term OWNER TO maurodatamapperuser;

--
-- Name: join_term_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.join_term_to_facet (
    term_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_term_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_terminology_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.join_terminology_to_facet (
    terminology_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_terminology_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_termrelationship_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.join_termrelationship_to_facet (
    termrelationship_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_termrelationship_to_facet OWNER TO maurodatamapperuser;

--
-- Name: join_termrelationshiptype_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.join_termrelationshiptype_to_facet (
    termrelationshiptype_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_termrelationshiptype_to_facet OWNER TO maurodatamapperuser;

--
-- Name: term; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.term (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    url character varying(255),
    definition text NOT NULL,
    terminology_id uuid NOT NULL,
    is_parent boolean NOT NULL,
    code character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE terminology.term OWNER TO maurodatamapperuser;

--
-- Name: term_relationship; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.term_relationship (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    target_term_id uuid NOT NULL,
    relationship_type_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    source_term_id uuid NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE terminology.term_relationship OWNER TO maurodatamapperuser;

--
-- Name: term_relationship_type; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.term_relationship_type (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    child_relationship boolean NOT NULL,
    terminology_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    parental_relationship boolean NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    display_label character varying(255) NOT NULL,
    description text
);


ALTER TABLE terminology.term_relationship_type OWNER TO maurodatamapperuser;

--
-- Name: terminology; Type: TABLE; Schema: terminology; Owner: maurodatamapperuser
--

CREATE TABLE terminology.terminology (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid NOT NULL,
    folder_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    authority_id uuid,
    branch_name character varying(255),
    model_version character varying(255),
    model_version_tag character varying(255),
    path text NOT NULL
);


ALTER TABLE terminology.terminology OWNER TO maurodatamapperuser;

--
-- Data for Name: annotation; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.annotation (id, version, date_created, last_updated, path, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, parent_annotation_id, created_by, label, description, child_annotations_idx) FROM stdin;
\.


--
-- Data for Name: api_property; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.api_property (id, version, last_updated_by, date_created, last_updated, value, created_by, key, publicly_visible, category, path) FROM stdin;
91970414-2e4d-4969-9bec-fe28a31a0464	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.689932	2024-10-02 16:23:03.689932	Dear ${firstName},\nYou have been invited to edit the model '${itemLabel}' in the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour password is: ${tempPassword}\n and you will be asked to update this when you first log on.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.invite_edit.body	f	Email	api:Email.email.invite_edit.body
869d65dc-5e75-4c9c-a6e9-82eccdb9dda9	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.721491	2024-10-02 16:23:03.721491	Dear ${firstName},\nYou have been given access to the Mauro Data Mapper at ${catalogueUrl} \n\nYour username / email address is: ${emailAddress} \nYour password is: ${tempPassword} \nand you will be asked to update this when you first log on.\n\nKind regards, the Mauro Data Mapper folks. \n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.admin_register.body	f	Email	api:Email.email.admin_register.body
ff76ee15-4260-4c73-aee1-369cb3050047	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.722061	2024-10-02 16:23:03.722061	Mauro Data Mapper Registration	bootstrap.user@maurodatamapper.com	email.admin_register.subject	f	Email	api:Email.email.admin_register.subject
8b116273-211b-47f3-9d8f-a88528da39b1	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.722442	2024-10-02 16:23:03.722442	Mauro Data Mapper Registration	bootstrap.user@maurodatamapper.com	email.self_register.subject	f	Email	api:Email.email.self_register.subject
d0f759b2-c232-4d25-96e4-8e388128b461	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.722791	2024-10-02 16:23:03.722791	Mauro Data Mapper Forgotten Password	bootstrap.user@maurodatamapper.com	email.forgotten_password.subject	f	Email	api:Email.email.forgotten_password.subject
2023cdac-5267-4993-bb9e-0f18e68e84d4	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.723135	2024-10-02 16:23:03.723135	Mauro Data Mapper Invitation	bootstrap.user@maurodatamapper.com	email.invite_edit.subject	f	Email	api:Email.email.invite_edit.subject
faeca897-9351-4890-a87f-60aeb639a1de	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.723699	2024-10-02 16:23:03.723699	Mauro Data Mapper Invitation	bootstrap.user@maurodatamapper.com	email.invite_view.subject	f	Email	api:Email.email.invite_view.subject
57e3d19b-7d95-49c8-a8f1-3f96047c4ca0	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.724125	2024-10-02 16:23:03.724125	Dear ${firstName},\nYour registration for the Mauro Data Mapper at ${catalogueUrl} has been confirmed.\n\nYour username / email address is: ${emailAddress} \nYou chose a password on registration, but can reset it from the login page.\n\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.admin_confirm_registration.body	f	Email	api:Email.email.admin_confirm_registration.body
6b0120e3-c133-4574-98cb-bc534194f29e	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.724595	2024-10-02 16:23:03.724595	Dear ${firstName},\nYou have self-registered for the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour registration is marked as pending: you'll be sent another email when your request has been confirmed by an administrator. \nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.self_register.body	f	Email	api:Email.email.self_register.body
9c244d29-1805-4f7b-9520-836d01313df1	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.724924	2024-10-02 16:23:03.724924	Dear ${firstName},\nYour password has been reset for the Mauro Data Mapper at ${catalogueUrl}.\n\nYour new temporary password is: ${tempPassword} \nand you will be asked to update this when you next log on.\n\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.password_reset.body	f	Email	api:Email.email.password_reset.body
00e0b8bd-155f-4b47-a1de-16bc15ae15ac	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.725415	2024-10-02 16:23:03.725415	Mauro Data Mapper	bootstrap.user@maurodatamapper.com	email.from.name	f	Email	api:Email.email.from.name
a8a20d00-ac40-436e-9975-6fe580684327	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.725801	2024-10-02 16:23:03.725801	Mauro Data Mapper Registration - Confirmation	bootstrap.user@maurodatamapper.com	email.admin_confirm_registration.subject	f	Email	api:Email.email.admin_confirm_registration.subject
87e5a790-7a32-45c9-ba62-54e2cb47d243	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.726364	2024-10-02 16:23:03.726364	Dear ${firstName},\nA request has been made to reset the password for the Mauro Data Mapper at ${catalogueUrl}.\nIf you did not make this request please ignore this email.\n\nPlease use the following link to reset your password ${passwordResetLink}.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.forgotten_password.body	f	Email	api:Email.email.forgotten_password.body
b3e167cb-b12e-4998-92b6-b94bf65e2827	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.726686	2024-10-02 16:23:03.726686	Mauro Data Mapper Password Reset	bootstrap.user@maurodatamapper.com	email.password_reset.subject	f	Email	api:Email.email.password_reset.subject
e100c076-e702-4dd4-9a4e-5b40c8ff29f3	0	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.72701	2024-10-02 16:23:03.72701	Dear ${firstName},\nYou have been invited to view the item '${itemLabel}' in the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour password is: ${tempPassword}\n and you will be asked to update this when you first log on.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.invite_view.body	f	Email	api:Email.email.invite_view.body
d6b3f676-d6a5-4dab-b0df-f030b6a80a6f	1	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:03.774349	2024-10-02 16:23:03.776341	190	bootstrap.user@maurodatamapper.com	feature.attachment_size_limit_mb	f	Feature	api:Feature.feature.attachment_size_limit_mb
808f66d7-ceab-4b2c-b13b-ebd385d85d1d	0	admin@maurodatamapper.com	2024-10-02 16:23:04.374012	2024-10-02 16:23:04.374012	true	admin@maurodatamapper.com	auto_register_users	f	Open ID Connect Properties	api:Open ID Connect Properties.auto_register_users
85926dd2-42b7-4807-9d65-3766231c5e0c	1	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:04.39732	2024-10-02 16:23:04.398179	dd/MM/yyyy,dd-MM-yyyy,MM/dd/yyyy,MM-dd-yyyy,yyyy/MM/dd,yyyy-MM-dd	bootstrap.user@maurodatamapper.com	datatype.date.formats	f	profile	api:profile.datatype.date.formats
a86c50bb-7d01-4269-bc18-3699a04ec6b7	1	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:04.404209	2024-10-02 16:23:04.405391	dd/MM/yyyy'T'HH:mm:ss,dd-MM-yyyy'T'HH:mm:ss	bootstrap.user@maurodatamapper.com	datatype.datetime.formats	f	profile	api:profile.datatype.datetime.formats
2e189093-2f59-4366-8534-2bf10d2295f5	1	bootstrap.user@maurodatamapper.com	2024-10-02 16:23:04.410942	2024-10-02 16:23:04.411803	HH:mm:ss,HH:mm	bootstrap.user@maurodatamapper.com	datatype.time.formats	f	profile	api:profile.datatype.time.formats
6f545610-978b-40ee-9ebb-8a1bc3fa23cf	1	admin@maurodatamapper.com	2024-10-02 16:23:37.923206	2024-10-02 16:23:37.924324	true	admin@maurodatamapper.com	feature.use_open_id_connect	t	Features	api:Features.feature.use_open_id_connect
\.


--
-- Data for Name: async_job; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.async_job (id, version, date_created, last_updated, path, started_by_user, date_time_started, job_name, created_by, status, message) FROM stdin;
\.


--
-- Data for Name: authority; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.authority (id, version, date_created, last_updated, readable_by_authenticated_users, url, created_by, readable_by_everyone, label, description, default_authority, path) FROM stdin;
e861db56-41a4-4a9b-ac7a-2ac30aae74b9	0	2024-10-02 16:23:03.836599	2024-10-02 16:23:03.836599	t	http://localhost	admin@maurodatamapper.com	t	Mauro Data Mapper	\N	t	auth:Mauro Data Mapper@http://localhost
\.


--
-- Data for Name: breadcrumb_tree; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.breadcrumb_tree (id, version, domain_type, finalised, domain_id, tree_string, top_breadcrumb_tree, label, parent_id, path) FROM stdin;
\.


--
-- Data for Name: classifier; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.classifier (id, version, date_created, last_updated, path, parent_classifier_id, readable_by_authenticated_users, created_by, readable_by_everyone, label, description) FROM stdin;
\.


--
-- Data for Name: domain_export; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.domain_export (id, version, multi_domain_export, date_created, exporter_namespace, export_file_name, last_updated, path, exported_domain_ids, exported_domain_type, exporter_name, exported_domain_id, export_data, created_by, exporter_version, export_content_type) FROM stdin;
\.


--
-- Data for Name: edit; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.edit (id, version, date_created, last_updated, resource_domain_type, resource_id, created_by, description, title, path) FROM stdin;
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.email (id, version, sent_to_email_address, successfully_sent, body, date_time_sent, email_service_used, failure_reason, subject) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.0.0	core	SQL	V1_0_0__core.sql	30735148	maurodatamapperuser	2024-10-02 16:22:58.764495	81	t
2	1.5.0	authority	SQL	V1_5_0__authority.sql	1820762963	maurodatamapperuser	2024-10-02 16:22:58.85062	7	t
3	1.7.0	semantic link add unconfirmed	SQL	V1_7_0__semantic_link_add_unconfirmed.sql	490568862	maurodatamapperuser	2024-10-02 16:22:58.86244	1	t
4	1.13.0	add versioned folder	SQL	V1_13_0__add_versioned_folder.sql	1714761766	maurodatamapperuser	2024-10-02 16:22:58.868166	2	t
5	1.15.0	add rule	SQL	V1_15_0__add_rule.sql	1865268520	maurodatamapperuser	2024-10-02 16:22:58.873209	6	t
6	1.15.5	add rulerepresentation	SQL	V1_15_5__add_rulerepresentation.sql	-2123765594	maurodatamapperuser	2024-10-02 16:22:58.882174	10	t
0	\N	<< Flyway Schema Creation >>	SCHEMA	"core"	\N	maurodatamapperuser	2024-10-02 16:22:58.732789	0	t
7	2.0.0	fix flyway	SQL	V2_0_0__fix_flyway.sql	-995285273	maurodatamapperuser	2024-10-02 16:22:58.900276	31	t
8	2.1.0	add delete cascade to some foreign keys	SQL	V2_1_0__add_delete_cascade_to_some_foreign_keys.sql	1123726048	maurodatamapperuser	2024-10-02 16:22:58.934905	2	t
9	2.2.0	update edit description to text type	SQL	V2_2_0__update_edit_description_to_text_type.sql	758628834	maurodatamapperuser	2024-10-02 16:22:58.939408	1	t
10	2.3.0	model import	SQL	V2_3_0__model_import.sql	969010724	maurodatamapperuser	2024-10-02 16:22:58.942912	6	t
11	2.3.1	model extend	SQL	V2_3_1__model_extend.sql	423308479	maurodatamapperuser	2024-10-02 16:22:58.952718	6	t
12	2.4.0	update api properties	SQL	V2_4_0__update_api_properties.sql	185217942	maurodatamapperuser	2024-10-02 16:22:58.961556	1	t
13	2.5.0	add model version tag to versioned folder	SQL	V2_5_0__add_model_version_tag_to_versioned_folder.sql	-1320780895	maurodatamapperuser	2024-10-02 16:22:58.965173	1	t
14	2.6.0	add indexing to metadata	SQL	V2_6_0__add_indexing_to_metadata.sql	703739930	maurodatamapperuser	2024-10-02 16:22:58.968038	3	t
15	2.7.0	add and migrate edit title	SQL	V2_7_0__add_and_migrate_edit_title.sql	-665000924	maurodatamapperuser	2024-10-02 16:22:58.974382	1	t
16	2.8.0	rename catalogue item to multi facet	SQL	V2_8_0__rename_catalogue_item_to_multi_facet.sql	-491830151	maurodatamapperuser	2024-10-02 16:22:58.979525	2	t
17	2.8.1	containers add facets	SQL	V2_8_1__containers_add_facets.sql	824749235	maurodatamapperuser	2024-10-02 16:22:58.986534	8	t
18	2.8.2	remove model import export	SQL	V2_8_2__remove_model_import_export.sql	-1422014840	maurodatamapperuser	2024-10-02 16:22:58.99723	1	t
19	2.9.0	add version links to versioned folder	SQL	V2_9_0__add_version_links_to_versioned_folder.sql	-1431906977	maurodatamapperuser	2024-10-02 16:22:59.001535	2	t
20	2.10.0	add default authority field	SQL	V2_10_0__add_default_authority_field.sql	-564973694	maurodatamapperuser	2024-10-02 16:22:59.006079	1	t
21	2.11.0	allow emails to not have a provider	SQL	V2_11_0__allow_emails_to_not_have_a_provider.sql	368894562	maurodatamapperuser	2024-10-02 16:22:59.009476	1	t
22	3.0.0	remove depth	SQL	V3_0_0__remove_depth.sql	1328451108	maurodatamapperuser	2024-10-02 16:22:59.012358	1	t
23	5.0.0	update to v5 domains	SQL	V5_0_0__update_to_v5_domains.sql	2056450125	maurodatamapperuser	2024-10-02 16:22:59.016393	5	t
24	5.0.1	update paths	JDBC	db.migration.core.V5_0_1__update_paths	\N	maurodatamapperuser	2024-10-02 16:22:59.023974	103	t
25	5.0.2	fix paths with plus	SQL	V5_0_2__fix_paths_with_plus.sql	2130110809	maurodatamapperuser	2024-10-02 16:22:59.130988	4	t
26	5.1.0	add async job	SQL	V5_1_0__add_async_job.sql	199154022	maurodatamapperuser	2024-10-02 16:22:59.137715	5	t
27	5.1.1	add domain export	SQL	V5_1_1__add_domain_export.sql	-1448630993	maurodatamapperuser	2024-10-02 16:22:59.145747	4	t
28	5.1.2	rename file type to content type	SQL	V5_1_2__rename_file_type_to_content_type.sql	-1596777495	maurodatamapperuser	2024-10-02 16:22:59.151253	1	t
29	5.1.3	delete invalid breadcrumb trees	SQL	V5_1_3__delete_invalid_breadcrumb_trees.sql	-1978164369	maurodatamapperuser	2024-10-02 16:22:59.154663	3	t
30	5.2.1	alter image file	SQL	V5_2_1__alter_image_file.sql	522529945	maurodatamapperuser	2024-10-02 16:22:59.160413	1	t
31	5.2.2	add indexes	SQL	V5_2_2__add_indexes.sql	-1596357960	maurodatamapperuser	2024-10-02 16:22:59.16349	2	t
32	5.3.0	add indexes	SQL	V5_3_0__add_indexes.sql	-321949902	maurodatamapperuser	2024-10-02 16:22:59.167527	2	t
\.


--
-- Data for Name: folder; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.folder (id, version, date_created, last_updated, path, deleted, readable_by_authenticated_users, parent_folder_id, created_by, readable_by_everyone, label, description, class, branch_name, finalised, date_finalised, documentation_version, model_version, authority_id, model_version_tag) FROM stdin;
9b23cf9a-c78d-4da5-ab3b-db83fadbd14b	0	2024-10-02 16:23:04.324844	2024-10-02 16:23:04.324844	fo:Example Folder	f	t	\N	admin@maurodatamapper.com	f	Example Folder	This folder is readable by all authenticated users, and currently only editable by users in the administrators group. Future suggestions: rename this folder to be more descriptive, and alter group access.	uk.ac.ox.softeng.maurodatamapper.core.container.Folder	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: image_file; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.image_file (id, version, file_size, date_created, last_updated, file_type, file_name, user_id, file_contents, created_by, path, class) FROM stdin;
\.


--
-- Data for Name: join_classifier_to_facet; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.join_classifier_to_facet (classifier_id, annotation_id, rule_id, semantic_link_id, reference_file_id, metadata_id) FROM stdin;
\.


--
-- Data for Name: join_folder_to_facet; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.join_folder_to_facet (folder_id, annotation_id, rule_id, semantic_link_id, reference_file_id, metadata_id) FROM stdin;
\.


--
-- Data for Name: join_versionedfolder_to_facet; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.join_versionedfolder_to_facet (versionedfolder_id, version_link_id) FROM stdin;
\.


--
-- Data for Name: metadata; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.metadata (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, namespace, multi_facet_aware_item_id, value, created_by, key, path) FROM stdin;
\.


--
-- Data for Name: reference_file; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.reference_file (id, version, file_size, date_created, last_updated, multi_facet_aware_item_domain_type, file_type, file_name, file_contents, multi_facet_aware_item_id, created_by, path) FROM stdin;
\.


--
-- Data for Name: rule; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.rule (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, name, created_by, description, path) FROM stdin;
\.


--
-- Data for Name: rule_representation; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.rule_representation (id, version, date_created, last_updated, rule_id, language, representation, created_by, path) FROM stdin;
\.


--
-- Data for Name: semantic_link; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.semantic_link (id, version, date_created, target_multi_facet_aware_item_id, last_updated, multi_facet_aware_item_domain_type, target_multi_facet_aware_item_domain_type, link_type, multi_facet_aware_item_id, created_by, unconfirmed, path) FROM stdin;
\.


--
-- Data for Name: version_link; Type: TABLE DATA; Schema: core; Owner: maurodatamapperuser
--

COPY core.version_link (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, target_model_domain_type, link_type, target_model_id, multi_facet_aware_item_id, created_by, path) FROM stdin;
\.


--
-- Data for Name: data_class_component; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.data_class_component (id, version, date_created, data_flow_id, definition, last_updated, path, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
\.


--
-- Data for Name: data_element_component; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.data_element_component (id, version, date_created, data_class_component_id, definition, last_updated, path, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
\.


--
-- Data for Name: data_flow; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.data_flow (id, version, date_created, definition, diagram_layout, last_updated, path, source_id, breadcrumb_tree_id, target_id, idx, created_by, aliases_string, label, description) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.4.0	dataflow	SQL	V1_4_0__dataflow.sql	1607778436	maurodatamapperuser	2024-10-02 16:23:00.092307	34	t
2	1.15.4	add rule to dataflow	SQL	V1_15_4__add_rule_to_dataflow.sql	-73896718	maurodatamapperuser	2024-10-02 16:23:00.129947	3	t
3	3.0.0	remove depth	SQL	V3_0_0__remove_depth.sql	2051749072	maurodatamapperuser	2024-10-02 16:23:00.134849	1	t
4	5.0.1	update paths	JDBC	db.migration.dataflow.V5_0_1__update_paths	\N	maurodatamapperuser	2024-10-02 16:23:00.138084	4	t
5	5.0.2	fix paths with plus	SQL	V5_0_2__fix_paths_with_plus.sql	675364976	maurodatamapperuser	2024-10-02 16:23:00.144825	2	t
\.


--
-- Data for Name: join_data_class_component_to_source_data_class; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.join_data_class_component_to_source_data_class (data_class_component_id, data_class_id) FROM stdin;
\.


--
-- Data for Name: join_data_class_component_to_target_data_class; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.join_data_class_component_to_target_data_class (data_class_component_id, data_class_id) FROM stdin;
\.


--
-- Data for Name: join_data_element_component_to_source_data_element; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.join_data_element_component_to_source_data_element (data_element_component_id, data_element_id) FROM stdin;
\.


--
-- Data for Name: join_data_element_component_to_target_data_element; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.join_data_element_component_to_target_data_element (data_element_component_id, data_element_id) FROM stdin;
\.


--
-- Data for Name: join_dataclasscomponent_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.join_dataclasscomponent_to_facet (dataclasscomponent_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_dataelementcomponent_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.join_dataelementcomponent_to_facet (dataelementcomponent_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_dataflow_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapperuser
--

COPY dataflow.join_dataflow_to_facet (dataflow_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.data_class (id, version, date_created, last_updated, path, min_multiplicity, max_multiplicity, parent_data_class_id, breadcrumb_tree_id, data_model_id, idx, created_by, aliases_string, label, description) FROM stdin;
\.


--
-- Data for Name: data_element; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.data_element (id, version, date_created, data_class_id, last_updated, path, min_multiplicity, max_multiplicity, breadcrumb_tree_id, data_type_id, idx, created_by, aliases_string, label, description) FROM stdin;
\.


--
-- Data for Name: data_model; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.data_model (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag, path) FROM stdin;
\.


--
-- Data for Name: data_type; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.data_type (id, version, date_created, domain_type, last_updated, path, breadcrumb_tree_id, data_model_id, idx, created_by, aliases_string, label, description, class, units, reference_class_id, model_resource_id, model_resource_domain_type) FROM stdin;
\.


--
-- Data for Name: enumeration_value; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.enumeration_value (id, version, date_created, enumeration_type_id, value, last_updated, path, breadcrumb_tree_id, idx, category, created_by, aliases_string, key, label, description) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.1.0	datamodel	SQL	V1_1_0__datamodel.sql	-1078313268	maurodatamapperuser	2024-10-02 16:22:59.2004	68	t
2	1.5.1	add authority to datamodel	SQL	V1_5_1__add_authority_to_datamodel.sql	-189904092	maurodatamapperuser	2024-10-02 16:22:59.272762	1	t
3	1.6.0	add extra model properties to datamodel	SQL	V1_6_0__add_extra_model_properties_to_datamodel.sql	1674821418	maurodatamapperuser	2024-10-02 16:22:59.276599	1	t
4	1.9.0	make sure data model type is correct	SQL	V1_9_0__make_sure_data_model_type_is_correct.sql	-1826314098	maurodatamapperuser	2024-10-02 16:22:59.279344	0	t
5	1.11.0	add model data type	SQL	V1_11_0__add_model_data_type.sql	-1282220622	maurodatamapperuser	2024-10-02 16:22:59.281556	0	t
6	1.15.1	add rule to datamodel	SQL	V1_15_1__add_rule_to_datamodel.sql	1543299352	maurodatamapperuser	2024-10-02 16:22:59.284418	3	t
7	2.0.0	add model version tag to datamodel	SQL	V2_0_0__add_model_version_tag_to_datamodel.sql	999639261	maurodatamapperuser	2024-10-02 16:22:59.290722	0	t
8	2.1.0	model import	SQL	V2_1_0__model_import.sql	-67495030	maurodatamapperuser	2024-10-02 16:22:59.293066	2	t
9	2.1.1	model extend	SQL	V2_1_1__model_extend.sql	827809470	maurodatamapperuser	2024-10-02 16:22:59.29747	1	t
10	2.2.0	rename catalogue item to multi facet	SQL	V2_2_0__rename_catalogue_item_to_multi_facet.sql	1051322676	maurodatamapperuser	2024-10-02 16:22:59.300553	1	t
11	2.2.1	remove model import export	SQL	V2_2_1__remove_model_import_export.sql	1494610551	maurodatamapperuser	2024-10-02 16:22:59.303337	3	t
12	2.2.3	add dataclass extension	SQL	V2_2_3__add_dataclass_extension.sql	601991483	maurodatamapperuser	2024-10-02 16:22:59.308662	2	t
13	2.2.4	add importing	SQL	V2_2_4__add_importing.sql	-1631221524	maurodatamapperuser	2024-10-02 16:22:59.312702	4	t
14	2.10.0	fix erroneous new model of and wrong direction version links	SQL	V2_10_0__fix_erroneous_new_model_of_and_wrong_direction_version_links.sql	-440622816	maurodatamapperuser	2024-10-02 16:22:59.319562	3	t
15	2.11.0	update database metadata values	SQL	V2_11_0__update_database_metadata_values.sql	1326997038	maurodatamapperuser	2024-10-02 16:22:59.325163	9	t
16	3.0.0	remove depth	SQL	V3_0_0__remove_depth.sql	-1796358613	maurodatamapperuser	2024-10-02 16:22:59.337126	2	t
17	5.0.0	update to v5 domains	SQL	V5_0_0__update_to_v5_domains.sql	1214626348	maurodatamapperuser	2024-10-02 16:22:59.341373	2	t
18	5.0.1	fix null domain id in breadcrumb tree	SQL	V5_0_1__fix_null_domain_id_in_breadcrumb_tree.sql	1774043654	maurodatamapperuser	2024-10-02 16:22:59.345577	1	t
19	5.0.2	update paths	JDBC	db.migration.datamodel.V5_0_2__update_paths	\N	maurodatamapperuser	2024-10-02 16:22:59.347759	68	t
20	5.0.3	fix paths with plus	SQL	V5_0_3__fix_paths_with_plus.sql	-1933468078	maurodatamapperuser	2024-10-02 16:22:59.419946	4	t
21	5.1.0	fix branch names from vfs	SQL	V5_1_0__fix_branch_names_from_vfs.sql	801976153	maurodatamapperuser	2024-10-02 16:22:59.426044	1	t
22	5.1.1	add indexes	SQL	V5_1_1__add_indexes.sql	-2001891266	maurodatamapperuser	2024-10-02 16:22:59.429814	46	t
23	5.1.2	add indexes	SQL	V5_1_2__add_indexes.sql	-940714381	maurodatamapperuser	2024-10-02 16:22:59.477932	9	t
24	5.3.0	add indexes	SQL	V5_3_0__add_indexes.sql	-1612749873	maurodatamapperuser	2024-10-02 16:22:59.489511	14	t
\.


--
-- Data for Name: join_dataclass_to_extended_data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_dataclass_to_extended_data_class (dataclass_id, extended_dataclass_id) FROM stdin;
\.


--
-- Data for Name: join_dataclass_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_dataclass_to_facet (dataclass_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_dataclass_to_imported_data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_dataclass_to_imported_data_class (imported_dataclass_id, dataclass_id) FROM stdin;
\.


--
-- Data for Name: join_dataclass_to_imported_data_element; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_dataclass_to_imported_data_element (dataclass_id, imported_dataelement_id) FROM stdin;
\.


--
-- Data for Name: join_dataelement_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_dataelement_to_facet (dataelement_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_datamodel_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_datamodel_to_facet (datamodel_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_datamodel_to_imported_data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_datamodel_to_imported_data_class (imported_dataclass_id, datamodel_id) FROM stdin;
\.


--
-- Data for Name: join_datamodel_to_imported_data_type; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_datamodel_to_imported_data_type (imported_datatype_id, datamodel_id) FROM stdin;
\.


--
-- Data for Name: join_datatype_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_datatype_to_facet (datatype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_enumerationvalue_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.join_enumerationvalue_to_facet (enumerationvalue_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: summary_metadata; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.summary_metadata (id, version, summary_metadata_type, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, created_by, label, description, path) FROM stdin;
\.


--
-- Data for Name: summary_metadata_report; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapperuser
--

COPY datamodel.summary_metadata_report (id, version, date_created, last_updated, report_date, created_by, report_value, summary_metadata_id, path) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: federation; Owner: maurodatamapperuser
--

COPY federation.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
0	\N	<< Flyway Schema Creation >>	SCHEMA	"federation"	\N	maurodatamapperuser	2024-10-02 16:22:59.523337	0	t
1	1.0.0	subscribed catalogue	SQL	V1_0_0__subscribed_catalogue.sql	664848546	maurodatamapperuser	2024-10-02 16:22:59.526125	10	t
2	1.1.0	allow public connections	SQL	V1_1_0__allow_public_connections.sql	-1099084963	maurodatamapperuser	2024-10-02 16:22:59.538775	0	t
3	1.2.0	add sc connectiontimeout and drop refreshperiod not null	SQL	V1_2_0__add_sc_connectiontimeout_and_drop_refreshperiod_not_null.sql	1670946949	maurodatamapperuser	2024-10-02 16:22:59.541232	0	t
4	5.0.0	update to v5 domains	SQL	V5_0_0__update_to_v5_domains.sql	-268645774	maurodatamapperuser	2024-10-02 16:22:59.543389	0	t
5	5.1.0	add subscribed catalogue type and convert subscribed catalogue id	SQL	V5_1_0__add_subscribed_catalogue_type_and_convert_subscribed_catalogue_id.sql	-940767646	maurodatamapperuser	2024-10-02 16:22:59.545665	7	t
6	5.2.0	add subscribed catalogue authentication credentials	SQL	V5_2_0__add_subscribed_catalogue_authentication_credentials.sql	-1081670259	maurodatamapperuser	2024-10-02 16:22:59.554949	3	t
\.


--
-- Data for Name: subscribed_catalogue; Type: TABLE DATA; Schema: federation; Owner: maurodatamapperuser
--

COPY federation.subscribed_catalogue (id, version, date_created, last_updated, readable_by_authenticated_users, readable_by_everyone, created_by, url, refresh_period, label, description, last_read, connection_timeout, path, subscribed_catalogue_type, subscribed_catalogue_authentication_type) FROM stdin;
\.


--
-- Data for Name: subscribed_catalogue_authentication_credentials; Type: TABLE DATA; Schema: federation; Owner: maurodatamapperuser
--

COPY federation.subscribed_catalogue_authentication_credentials (id, version, subscribed_catalogue_id, api_key, token_url, client_id, client_secret, access_token, access_token_expiry_time, class) FROM stdin;
\.


--
-- Data for Name: subscribed_model; Type: TABLE DATA; Schema: federation; Owner: maurodatamapperuser
--

COPY federation.subscribed_model (id, version, date_created, last_updated, readable_by_authenticated_users, readable_by_everyone, created_by, subscribed_catalogue_id, subscribed_model_id, subscribed_model_type, folder_id, last_read, local_model_id, path) FROM stdin;
\.


--
-- Data for Name: authorization_endpoint_parameters; Type: TABLE DATA; Schema: openidconnect; Owner: maurodatamapperuser
--

COPY openidconnect.authorization_endpoint_parameters (id, version, date_created, last_updated, ui_locales, display, prompt, scope, acr_values, id_token_hint, login_hint, max_age, created_by, response_type, response_mode, path) FROM stdin;
0b2445e6-e9e6-464c-9fb3-266f8593625f	0	2024-10-02 16:24:38.555467	2024-10-02 16:24:38.555467	\N	\N	\N	openid email profile	\N	\N	\N	\N	admin@maurodatamapper.com	code	\N	\N
\.


--
-- Data for Name: discovery_document; Type: TABLE DATA; Schema: openidconnect; Owner: maurodatamapperuser
--

COPY openidconnect.discovery_document (id, version, date_created, last_updated, token_endpoint, end_session_endpoint, userinfo_endpoint, created_by, authorization_endpoint, jwks_uri, issuer, path) FROM stdin;
540e91b3-09eb-4ac2-b05c-4cc86a28012f	0	2024-10-02 16:24:38.555966	2024-10-02 16:24:38.555966	http://keycloak:8080/realms/test/protocol/openid-connect/token	http://localhost:8095/realms/test/protocol/openid-connect/logout	http://keycloak:8080/realms/test/protocol/openid-connect/userinfo	admin@maurodatamapper.com	http://localhost:8095/realms/test/protocol/openid-connect/auth	http://keycloak:8080/realms/test/protocol/openid-connect/certs	http://localhost:8095/realms/test	\N
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: openidconnect; Owner: maurodatamapperuser
--

COPY openidconnect.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
0	\N	<< Flyway Schema Creation >>	SCHEMA	"openidconnect"	\N	maurodatamapperuser	2024-10-02 16:23:00.032613	0	t
1	1.0.0	add openid connect	SQL	V1_0_0__add_openid_connect.sql	893171619	maurodatamapperuser	2024-10-02 16:23:00.035999	24	t
2	5.0.0	update to v5 domains	SQL	V5_0_0__update_to_v5_domains.sql	373728609	maurodatamapperuser	2024-10-02 16:23:00.063525	1	t
\.


--
-- Data for Name: openid_connect_provider; Type: TABLE DATA; Schema: openidconnect; Owner: maurodatamapperuser
--

COPY openidconnect.openid_connect_provider (id, version, date_created, last_updated, discovery_document_url, authorization_endpoint_parameters_id, client_id, client_secret, discovery_document_id, created_by, standard_provider, label, image_url, path) FROM stdin;
b2092268-3014-4c24-a9cc-0913b2c63cfb	0	2024-10-02 16:24:38.556984	2024-10-02 16:24:38.556984	http://keycloak:8080/realms/test/.well-known/openid-configuration	0b2445e6-e9e6-464c-9fb3-266f8593625f	mdm	4b3b7290-7629-4b88-b310-df256adc8fed	540e91b3-09eb-4ac2-b05c-4cc86a28012f	admin@maurodatamapper.com	t	Keycloak	https://upload.wikimedia.org/wikipedia/commons/2/29/Keycloak_Logo.png?20200311211229	\N
\.


--
-- Data for Name: openid_connect_token; Type: TABLE DATA; Schema: openidconnect; Owner: maurodatamapperuser
--

COPY openidconnect.openid_connect_token (id, version, date_created, expires_in, last_updated, access_token, not_before_policy, session_id, token_type, catalogue_user_id, session_state, scope, refresh_token, openid_connect_provider_id, id_token, created_by, refresh_expires_in, path) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.12.0	referencedata	SQL	V1_12_0__referencedata.sql	-1371414334	maurodatamapperuser	2024-10-02 16:22:59.582315	61	t
2	1.14.0	fix errant referencedata tables	SQL	V1_14_0__fix_errant_referencedata_tables.sql	1211767792	maurodatamapperuser	2024-10-02 16:22:59.647797	5	t
3	1.15.3	add rule to referencedata	SQL	V1_15_3__add_rule_to_referencedata.sql	-29360414	maurodatamapperuser	2024-10-02 16:22:59.655119	3	t
4	2.0.0	unmodelitem reference data value	SQL	V2_0_0__unmodelitem_reference_data_value.sql	-1153312026	maurodatamapperuser	2024-10-02 16:22:59.660738	3	t
5	2.1.0	add model version tag to referencedata	SQL	V2_1_0__add_model_version_tag_to_referencedata.sql	479267627	maurodatamapperuser	2024-10-02 16:22:59.665653	0	t
6	2.2.0	rename catalogue item to multi facet	SQL	V2_2_0__rename_catalogue_item_to_multi_facet.sql	1531204225	maurodatamapperuser	2024-10-02 16:22:59.667657	0	t
7	2.3.0	add column number to element	SQL	V2_3_0__add_column_number_to_element.sql	-2013014767	maurodatamapperuser	2024-10-02 16:22:59.669485	0	t
8	3.0.0	remove depth	SQL	V3_0_0__remove_depth.sql	1050698690	maurodatamapperuser	2024-10-02 16:22:59.671312	0	t
9	5.0.0	update to v5 domains	SQL	V5_0_0__update_to_v5_domains.sql	1518752064	maurodatamapperuser	2024-10-02 16:22:59.673579	2	t
10	5.0.1	update paths	JDBC	db.migration.referencedata.V5_0_1__update_paths	\N	maurodatamapperuser	2024-10-02 16:22:59.676916	5	t
11	5.0.2	fix paths with plus	SQL	V5_0_2__fix_paths_with_plus.sql	-1631758498	maurodatamapperuser	2024-10-02 16:22:59.684429	2	t
12	5.1.0	fix branch names from vfs	SQL	V5_1_0__fix_branch_names_from_vfs.sql	1980055285	maurodatamapperuser	2024-10-02 16:22:59.689136	1	t
\.


--
-- Data for Name: join_referencedataelement_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.join_referencedataelement_to_facet (referencedataelement_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_referencedatamodel_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.join_referencedatamodel_to_facet (referencedatamodel_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_referencedatatype_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.join_referencedatatype_to_facet (referencedatatype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_referenceenumerationvalue_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.join_referenceenumerationvalue_to_facet (referenceenumerationvalue_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: reference_data_element; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.reference_data_element (id, version, date_created, reference_data_type_id, reference_data_model_id, last_updated, path, min_multiplicity, max_multiplicity, breadcrumb_tree_id, idx, created_by, aliases_string, label, description, column_number) FROM stdin;
\.


--
-- Data for Name: reference_data_model; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.reference_data_model (id, version, branch_name, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, model_version, folder_id, authority_id, created_by, aliases_string, label, description, model_version_tag, path) FROM stdin;
\.


--
-- Data for Name: reference_data_type; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.reference_data_type (id, version, date_created, reference_data_model_id, domain_type, last_updated, path, breadcrumb_tree_id, idx, created_by, aliases_string, label, description, class, units) FROM stdin;
\.


--
-- Data for Name: reference_data_value; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.reference_data_value (id, version, date_created, value, reference_data_model_id, reference_data_element_id, row_number, last_updated, created_by, path) FROM stdin;
\.


--
-- Data for Name: reference_enumeration_value; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.reference_enumeration_value (id, version, date_created, value, reference_enumeration_type_id, last_updated, path, breadcrumb_tree_id, idx, category, created_by, aliases_string, key, label, description) FROM stdin;
\.


--
-- Data for Name: reference_summary_metadata; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.reference_summary_metadata (id, version, summary_metadata_type, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, created_by, label, description, path) FROM stdin;
\.


--
-- Data for Name: reference_summary_metadata_report; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapperuser
--

COPY referencedata.reference_summary_metadata_report (id, version, date_created, last_updated, report_date, created_by, report_value, summary_metadata_id, path) FROM stdin;
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: security; Owner: maurodatamapperuser
--

COPY security.api_key (id, version, refreshable, date_created, expiry_date, last_updated, disabled, catalogue_user_id, name, created_by, path) FROM stdin;
\.


--
-- Data for Name: catalogue_user; Type: TABLE DATA; Schema: security; Owner: maurodatamapperuser
--

COPY security.catalogue_user (id, version, pending, salt, date_created, first_name, profile_picture_id, last_updated, organisation, reset_token, disabled, job_title, email_address, user_preferences, password, created_by, temp_password, last_name, last_login, creation_method, path) FROM stdin;
b91a2197-b73d-457f-8998-00960467625a	0	f	\\x4c4b3d5560396340	2024-10-02 16:23:03.987893	Unlogged	\N	2024-10-02 16:23:03.987893	\N	\N	f	\N	unlogged_user@mdm-core.com	\N	\N	unlogged_user@mdm-core.com	\N	User	\N	Standard	cu:unlogged_user@mdm-core.com
d734e301-0897-400b-bfd8-78bd0d4db13d	3	f	\\x43627058365d4f35	2024-10-02 16:23:04.272998	Admin	\N	2024-10-02 16:24:29.517089	Oxford BRC Informatics	\N	f	God	admin@maurodatamapper.com	\N	\N	admin@maurodatamapper.com	password	User	2024-10-02 16:23:21.881498	Standard	cu:admin@maurodatamapper.com
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: security; Owner: maurodatamapperuser
--

COPY security.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.2.0	security	SQL	V1_2_0__security.sql	-666600599	maurodatamapperuser	2024-10-02 16:22:59.887256	33	t
2	1.8.0	add can finalise model	SQL	V1_8_0__add_can_finalise_model.sql	1474674104	maurodatamapperuser	2024-10-02 16:22:59.923835	1	t
3	1.10.0	add user group undeleteable	SQL	V1_10_0__add_user_group_undeleteable.sql	617768911	maurodatamapperuser	2024-10-02 16:22:59.927315	0	t
4	1.11.0	add api key	SQL	V1_11_0__add_api_key.sql	-351808098	maurodatamapperuser	2024-10-02 16:22:59.929621	6	t
5	2.0.0	remove extra securableresourcegrouprole columns	SQL	V2_0_0__remove_extra_securableresourcegrouprole_columns.sql	-794214980	maurodatamapperuser	2024-10-02 16:22:59.937626	6	t
6	2.1.0	cleanup non unique securableresourcegrouproles	SQL	V2_1_0__cleanup_non_unique_securableresourcegrouproles.sql	-1673556944	maurodatamapperuser	2024-10-02 16:22:59.94582	1	t
7	2.2.0	add creation method to users	SQL	V2_2_0__add_creation_method_to_users.sql	1701130066	maurodatamapperuser	2024-10-02 16:22:59.949195	1	t
8	2.3.0	cleanup subscribedmodel securableresourcegrouproles	SQL	V2_3_0__cleanup_subscribedmodel_securableresourcegrouproles.sql	2008771893	maurodatamapperuser	2024-10-02 16:22:59.952159	0	t
9	3.0.0	remove depth	SQL	V3_0_0__remove_depth.sql	1970414341	maurodatamapperuser	2024-10-02 16:22:59.954474	0	t
10	5.0.0	update to v5 domains	SQL	V5_0_0__update_to_v5_domains.sql	1365184616	maurodatamapperuser	2024-10-02 16:22:59.956921	2	t
11	5.0.1	update paths	JDBC	db.migration.security.V5_0_1__update_paths	\N	maurodatamapperuser	2024-10-02 16:22:59.960188	43	t
12	5.2.0	add securableresourcegrouprole constraint	SQL	V5_2_0__add_securableresourcegrouprole_constraint.sql	1610699022	maurodatamapperuser	2024-10-02 16:23:00.00587	2	t
\.


--
-- Data for Name: group_role; Type: TABLE DATA; Schema: security; Owner: maurodatamapperuser
--

COPY security.group_role (id, version, date_created, display_name, name, parent_id, last_updated, path, application_level_role, created_by) FROM stdin;
3b22d9dc-a773-4ffc-b9a8-be24cea25cfb	0	2024-10-02 16:23:03.913088	Site Administrator	site_admin	\N	2024-10-02 16:23:03.913088	gr:site_admin	t	mdm-security@maurodatamapper.com
ec7eaac8-6881-4cf4-8c03-35f366adb823	0	2024-10-02 16:23:03.923568	Application Administrator	application_admin	3b22d9dc-a773-4ffc-b9a8-be24cea25cfb	2024-10-02 16:23:03.923568	gr:site_admin|gr:application_admin	t	mdm-security@maurodatamapper.com
c56523ac-e401-44b0-a213-74551782b741	0	2024-10-02 16:23:03.92833	User Administrator	user_admin	ec7eaac8-6881-4cf4-8c03-35f366adb823	2024-10-02 16:23:03.92833	gr:site_admin|gr:application_admin|gr:user_admin	t	mdm-security@maurodatamapper.com
fe83eb92-dc27-4604-ad63-c0a28b4fd6e9	0	2024-10-02 16:23:03.929041	Group Administrator	group_admin	c56523ac-e401-44b0-a213-74551782b741	2024-10-02 16:23:03.929041	gr:site_admin|gr:application_admin|gr:user_admin|gr:group_admin	t	mdm-security@maurodatamapper.com
9586b84a-437a-4f34-9d84-2decb9b17da4	0	2024-10-02 16:23:03.929558	Container Group Administrator	container_group_admin	fe83eb92-dc27-4604-ad63-c0a28b4fd6e9	2024-10-02 16:23:03.929558	gr:site_admin|gr:application_admin|gr:user_admin|gr:group_admin|gr:container_group_admin	t	mdm-security@maurodatamapper.com
9a22c95f-eea1-4330-843c-7a9b14091474	0	2024-10-02 16:23:03.929944	Container Administrator	container_admin	3b22d9dc-a773-4ffc-b9a8-be24cea25cfb	2024-10-02 16:23:03.929944	gr:site_admin|gr:container_admin	f	mdm-security@maurodatamapper.com
a52ab568-e9bc-4ae1-a450-0c31e6449c87	0	2024-10-02 16:23:03.93058	Editor	editor	9a22c95f-eea1-4330-843c-7a9b14091474	2024-10-02 16:23:03.93058	gr:site_admin|gr:container_admin|gr:editor	f	mdm-security@maurodatamapper.com
8d432f20-2898-46ad-a7bf-21c3335a2347	0	2024-10-02 16:23:03.931335	Author	author	a52ab568-e9bc-4ae1-a450-0c31e6449c87	2024-10-02 16:23:03.931335	gr:site_admin|gr:container_admin|gr:editor|gr:author	f	mdm-security@maurodatamapper.com
5071ad8f-802d-4fd1-ac53-6f337357c174	0	2024-10-02 16:23:03.931817	Reviewer	reviewer	8d432f20-2898-46ad-a7bf-21c3335a2347	2024-10-02 16:23:03.931817	gr:site_admin|gr:container_admin|gr:editor|gr:author|gr:reviewer	f	mdm-security@maurodatamapper.com
0d37d47e-2312-4e0c-ad56-e169b8763e23	0	2024-10-02 16:23:03.932629	Reader	reader	5071ad8f-802d-4fd1-ac53-6f337357c174	2024-10-02 16:23:03.932629	gr:site_admin|gr:container_admin|gr:editor|gr:author|gr:reviewer|gr:reader	f	mdm-security@maurodatamapper.com
\.


--
-- Data for Name: join_catalogue_user_to_user_group; Type: TABLE DATA; Schema: security; Owner: maurodatamapperuser
--

COPY security.join_catalogue_user_to_user_group (catalogue_user_id, user_group_id) FROM stdin;
d734e301-0897-400b-bfd8-78bd0d4db13d	7c4ecd85-accf-4c58-81e4-bed6f412bed9
\.


--
-- Data for Name: securable_resource_group_role; Type: TABLE DATA; Schema: security; Owner: maurodatamapperuser
--

COPY security.securable_resource_group_role (id, version, securable_resource_id, user_group_id, date_created, securable_resource_domain_type, last_updated, group_role_id, created_by, path) FROM stdin;
3e9e9c36-eeb3-4338-b15f-79e402cfc614	0	9b23cf9a-c78d-4da5-ab3b-db83fadbd14b	7c4ecd85-accf-4c58-81e4-bed6f412bed9	2024-10-02 16:23:04.335781	Folder	2024-10-02 16:23:04.335781	9a22c95f-eea1-4330-843c-7a9b14091474	admin@maurodatamapper.com	\N
\.


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: security; Owner: maurodatamapperuser
--

COPY security.user_group (id, version, date_created, last_updated, name, application_group_role_id, created_by, description, undeleteable, path) FROM stdin;
7c4ecd85-accf-4c58-81e4-bed6f412bed9	0	2024-10-02 16:23:04.295799	2024-10-02 16:23:04.295799	administrators	3b22d9dc-a773-4ffc-b9a8-be24cea25cfb	admin@maurodatamapper.com	\N	t	ug:administrators
\.


--
-- Data for Name: code_set; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.code_set (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag, path) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.3.0	terminology	SQL	V1_3_0__terminology.sql	712422872	maurodatamapperuser	2024-10-02 16:22:59.713398	48	t
2	1.5.2	add authority to terminology	SQL	V1_5_2__add_authority_to_terminology.sql	303081238	maurodatamapperuser	2024-10-02 16:22:59.764383	1	t
3	1.6.1	add extra model properties to terminology	SQL	V1_6_1__add_extra_model_properties_to_terminology.sql	-507038112	maurodatamapperuser	2024-10-02 16:22:59.768249	1	t
4	1.15.2	add rule to terminology	SQL	V1_15_2__add_rule_to_terminology.sql	413736981	maurodatamapperuser	2024-10-02 16:22:59.771016	3	t
5	2.0.0	add model version tag to terminology and codeset	SQL	V2_0_0__add_model_version_tag_to_terminology_and_codeset.sql	1715495761	maurodatamapperuser	2024-10-02 16:22:59.775728	0	t
6	2.1.0	fix erroneous new model of and wrong direction version links	SQL	V2_1_0__fix_erroneous_new_model_of_and_wrong_direction_version_links.sql	372732891	maurodatamapperuser	2024-10-02 16:22:59.778847	4	t
7	3.0.0	remove depth	SQL	V3_0_0__remove_depth.sql	874878019	maurodatamapperuser	2024-10-02 16:22:59.785109	1	t
8	5.0.0	update to v5 domains	SQL	V5_0_0__update_to_v5_domains.sql	344560333	maurodatamapperuser	2024-10-02 16:22:59.787388	1	t
9	5.0.1	update paths	JDBC	db.migration.terminology.V5_0_1__update_paths	\N	maurodatamapperuser	2024-10-02 16:22:59.789529	5	t
10	5.0.2	fix paths with plus	SQL	V5_0_2__fix_paths_with_plus.sql	-487749560	maurodatamapperuser	2024-10-02 16:22:59.796505	2	t
11	5.1.0	fix branch names from vfs	SQL	V5_1_0__fix_branch_names_from_vfs.sql	1314674009	maurodatamapperuser	2024-10-02 16:22:59.799789	0	t
12	5.2.2	add indexes	SQL	V5_2_2__add_indexes.sql	-111771996	maurodatamapperuser	2024-10-02 16:22:59.802135	41	t
13	5.2.3	delete orphan term facets	SQL	V5_2_3__delete_orphan_term_facets.sql	-958097721	maurodatamapperuser	2024-10-02 16:22:59.846403	2	t
14	5.3.0	add indexes	SQL	V5_3_0__add_indexes.sql	1756118746	maurodatamapperuser	2024-10-02 16:22:59.850197	14	t
\.


--
-- Data for Name: join_codeset_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.join_codeset_to_facet (codeset_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_codeset_to_term; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.join_codeset_to_term (term_id, codeset_id) FROM stdin;
\.


--
-- Data for Name: join_term_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.join_term_to_facet (term_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_terminology_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.join_terminology_to_facet (terminology_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_termrelationship_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.join_termrelationship_to_facet (termrelationship_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_termrelationshiptype_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.join_termrelationshiptype_to_facet (termrelationshiptype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.term (id, version, date_created, url, definition, terminology_id, is_parent, code, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
\.


--
-- Data for Name: term_relationship; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.term_relationship (id, version, date_created, target_term_id, relationship_type_id, last_updated, path, source_term_id, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
\.


--
-- Data for Name: term_relationship_type; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.term_relationship_type (id, version, date_created, child_relationship, terminology_id, last_updated, path, breadcrumb_tree_id, parental_relationship, idx, created_by, aliases_string, label, display_label, description) FROM stdin;
\.


--
-- Data for Name: terminology; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapperuser
--

COPY terminology.terminology (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag, path) FROM stdin;
\.


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.annotation
    ADD CONSTRAINT annotation_pkey PRIMARY KEY (id);


--
-- Name: api_property api_property_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.api_property
    ADD CONSTRAINT api_property_pkey PRIMARY KEY (id);


--
-- Name: async_job async_job_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.async_job
    ADD CONSTRAINT async_job_pkey PRIMARY KEY (id);


--
-- Name: authority authority_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.authority
    ADD CONSTRAINT authority_pkey PRIMARY KEY (id);


--
-- Name: breadcrumb_tree breadcrumb_tree_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.breadcrumb_tree
    ADD CONSTRAINT breadcrumb_tree_pkey PRIMARY KEY (id);


--
-- Name: classifier classifier_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT classifier_pkey PRIMARY KEY (id);


--
-- Name: domain_export domain_export_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.domain_export
    ADD CONSTRAINT domain_export_pkey PRIMARY KEY (id);


--
-- Name: edit edit_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.edit
    ADD CONSTRAINT edit_pkey PRIMARY KEY (id);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: folder folder_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- Name: metadata metadata_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);


--
-- Name: reference_file reference_file_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.reference_file
    ADD CONSTRAINT reference_file_pkey PRIMARY KEY (id);


--
-- Name: rule rule_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.rule
    ADD CONSTRAINT rule_pkey PRIMARY KEY (id);


--
-- Name: rule_representation rule_representation_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.rule_representation
    ADD CONSTRAINT rule_representation_pkey PRIMARY KEY (id);


--
-- Name: semantic_link semantic_link_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.semantic_link
    ADD CONSTRAINT semantic_link_pkey PRIMARY KEY (id);


--
-- Name: classifier uk_j7bbt97ko557eewc3u50ha8ko; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT uk_j7bbt97ko557eewc3u50ha8ko UNIQUE (label);


--
-- Name: authority ukfcae2aea4497b223b1762d7b79a3; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.authority
    ADD CONSTRAINT ukfcae2aea4497b223b1762d7b79a3 UNIQUE (url, label);


--
-- Name: image_file user_image_file_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.image_file
    ADD CONSTRAINT user_image_file_pkey PRIMARY KEY (id);


--
-- Name: version_link version_link_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.version_link
    ADD CONSTRAINT version_link_pkey PRIMARY KEY (id);


--
-- Name: data_class_component data_class_component_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT data_class_component_pkey PRIMARY KEY (id);


--
-- Name: data_element_component data_element_component_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT data_element_component_pkey PRIMARY KEY (id);


--
-- Name: data_flow data_flow_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT data_flow_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: data_class data_class_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT data_class_pkey PRIMARY KEY (id);


--
-- Name: data_element data_element_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT data_element_pkey PRIMARY KEY (id);


--
-- Name: data_model data_model_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT data_model_pkey PRIMARY KEY (id);


--
-- Name: data_type data_type_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT data_type_pkey PRIMARY KEY (id);


--
-- Name: enumeration_value enumeration_value_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT enumeration_value_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: summary_metadata summary_metadata_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.summary_metadata
    ADD CONSTRAINT summary_metadata_pkey PRIMARY KEY (id);


--
-- Name: summary_metadata_report summary_metadata_report_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.summary_metadata_report
    ADD CONSTRAINT summary_metadata_report_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: federation; Owner: maurodatamapperuser
--

ALTER TABLE ONLY federation.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: subscribed_catalogue_authentication_credentials subscribed_catalogue_authentication_credentials_pkey; Type: CONSTRAINT; Schema: federation; Owner: maurodatamapperuser
--

ALTER TABLE ONLY federation.subscribed_catalogue_authentication_credentials
    ADD CONSTRAINT subscribed_catalogue_authentication_credentials_pkey PRIMARY KEY (id);


--
-- Name: subscribed_catalogue subscribed_catalogue_pkey; Type: CONSTRAINT; Schema: federation; Owner: maurodatamapperuser
--

ALTER TABLE ONLY federation.subscribed_catalogue
    ADD CONSTRAINT subscribed_catalogue_pkey PRIMARY KEY (id);


--
-- Name: subscribed_model subscribed_model_pkey; Type: CONSTRAINT; Schema: federation; Owner: maurodatamapperuser
--

ALTER TABLE ONLY federation.subscribed_model
    ADD CONSTRAINT subscribed_model_pkey PRIMARY KEY (id);


--
-- Name: authorization_endpoint_parameters authorization_endpoint_parameters_pkey; Type: CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.authorization_endpoint_parameters
    ADD CONSTRAINT authorization_endpoint_parameters_pkey PRIMARY KEY (id);


--
-- Name: discovery_document discovery_document_pkey; Type: CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.discovery_document
    ADD CONSTRAINT discovery_document_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: openid_connect_provider openid_connect_provider_pkey; Type: CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_provider
    ADD CONSTRAINT openid_connect_provider_pkey PRIMARY KEY (id);


--
-- Name: openid_connect_token openid_connect_token_pkey; Type: CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_token
    ADD CONSTRAINT openid_connect_token_pkey PRIMARY KEY (id);


--
-- Name: openid_connect_token uk4c34640a79eb7c33e398babc9f3c; Type: CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_token
    ADD CONSTRAINT uk4c34640a79eb7c33e398babc9f3c UNIQUE (catalogue_user_id, session_id);


--
-- Name: openid_connect_provider uk_hc3bjmsxauf094phcna8sdenr; Type: CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_provider
    ADD CONSTRAINT uk_hc3bjmsxauf094phcna8sdenr UNIQUE (label);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: reference_data_element reference_data_element_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT reference_data_element_pkey PRIMARY KEY (id);


--
-- Name: reference_data_model reference_data_model_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT reference_data_model_pkey PRIMARY KEY (id);


--
-- Name: reference_data_type reference_data_type_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT reference_data_type_pkey PRIMARY KEY (id);


--
-- Name: reference_data_value reference_data_value_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT reference_data_value_pkey PRIMARY KEY (id);


--
-- Name: reference_enumeration_value reference_enumeration_value_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT reference_enumeration_value_pkey PRIMARY KEY (id);


--
-- Name: reference_summary_metadata reference_summary_metadata_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_summary_metadata
    ADD CONSTRAINT reference_summary_metadata_pkey PRIMARY KEY (id);


--
-- Name: reference_summary_metadata_report reference_summary_metadata_report_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_summary_metadata_report
    ADD CONSTRAINT reference_summary_metadata_report_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: catalogue_user catalogue_user_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT catalogue_user_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: group_role group_role_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT group_role_pkey PRIMARY KEY (id);


--
-- Name: join_catalogue_user_to_user_group join_catalogue_user_to_user_group_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT join_catalogue_user_to_user_group_pkey PRIMARY KEY (user_group_id, catalogue_user_id);


--
-- Name: securable_resource_group_role securable_resource_group_role_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT securable_resource_group_role_pkey PRIMARY KEY (id);


--
-- Name: catalogue_user uk_26qjnuqu76954q376opkqelqd; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT uk_26qjnuqu76954q376opkqelqd UNIQUE (email_address);


--
-- Name: group_role uk_7kvrlnisllgg2md5614ywh82g; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT uk_7kvrlnisllgg2md5614ywh82g UNIQUE (name);


--
-- Name: user_group uk_kas9w8ead0ska5n3csefp2bpp; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT uk_kas9w8ead0ska5n3csefp2bpp UNIQUE (name);


--
-- Name: api_key ukee162bd1d3e12dac9f8ef55811f7; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT ukee162bd1d3e12dac9f8ef55811f7 UNIQUE (catalogue_user_id, name);


--
-- Name: securable_resource_group_role ukfa251ce1f3b24cad8cccd15394d1; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT ukfa251ce1f3b24cad8cccd15394d1 UNIQUE (securable_resource_id, user_group_id);


--
-- Name: user_group user_group_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT user_group_pkey PRIMARY KEY (id);


--
-- Name: code_set code_set_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT code_set_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: term term_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT term_pkey PRIMARY KEY (id);


--
-- Name: term_relationship term_relationship_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT term_relationship_pkey PRIMARY KEY (id);


--
-- Name: term_relationship_type term_relationship_type_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT term_relationship_type_pkey PRIMARY KEY (id);


--
-- Name: terminology terminology_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT terminology_pkey PRIMARY KEY (id);


--
-- Name: annotation_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX annotation_created_by_idx ON core.annotation USING btree (created_by);


--
-- Name: annotation_parent_annotation_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX annotation_parent_annotation_idx ON core.annotation USING btree (parent_annotation_id);


--
-- Name: apiproperty_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX apiproperty_created_by_idx ON core.api_property USING btree (created_by);


--
-- Name: asyncjob_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX asyncjob_created_by_idx ON core.async_job USING btree (created_by);


--
-- Name: authority_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX authority_created_by_idx ON core.authority USING btree (created_by);


--
-- Name: breadcrumb_tree_domain_id_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX breadcrumb_tree_domain_id_idx ON core.breadcrumb_tree USING btree (domain_id);


--
-- Name: breadcrumb_tree_parent_id_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX breadcrumb_tree_parent_id_idx ON core.breadcrumb_tree USING btree (parent_id);


--
-- Name: breadcrumb_tree_tree_string_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX breadcrumb_tree_tree_string_idx ON core.breadcrumb_tree USING btree (tree_string text_pattern_ops);


--
-- Name: breadcrumb_tree_tree_string_prefix_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX breadcrumb_tree_tree_string_prefix_idx ON core.breadcrumb_tree USING btree (substr(tree_string, 1, (36 + 1)));


--
-- Name: classifier_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX classifier_created_by_idx ON core.classifier USING btree (created_by);


--
-- Name: classifier_parent_classifier_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX classifier_parent_classifier_idx ON core.classifier USING btree (parent_classifier_id);


--
-- Name: domainexport_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX domainexport_created_by_idx ON core.domain_export USING btree (created_by);


--
-- Name: edit_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX edit_created_by_idx ON core.edit USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON core.flyway_schema_history USING btree (success);


--
-- Name: folder_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX folder_created_by_idx ON core.folder USING btree (created_by);


--
-- Name: folder_parent_folder_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX folder_parent_folder_idx ON core.folder USING btree (parent_folder_id);


--
-- Name: metadata_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX metadata_catalogue_item_idx ON core.metadata USING btree (multi_facet_aware_item_id);


--
-- Name: metadata_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX metadata_created_by_idx ON core.metadata USING btree (created_by);


--
-- Name: metadata_namespace_index; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX metadata_namespace_index ON core.metadata USING btree (namespace);


--
-- Name: metadata_namespace_key_index; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX metadata_namespace_key_index ON core.metadata USING btree (namespace, key);


--
-- Name: referencefile_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX referencefile_created_by_idx ON core.reference_file USING btree (created_by);


--
-- Name: rule_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX rule_catalogue_item_idx ON core.rule USING btree (multi_facet_aware_item_id);


--
-- Name: rule_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX rule_created_by_idx ON core.rule USING btree (created_by);


--
-- Name: rule_representation_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX rule_representation_created_by_idx ON core.rule_representation USING btree (created_by);


--
-- Name: rule_representation_rule_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX rule_representation_rule_idx ON core.rule_representation USING btree (rule_id);


--
-- Name: semantic_link_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX semantic_link_catalogue_item_idx ON core.semantic_link USING btree (multi_facet_aware_item_id);


--
-- Name: semantic_link_target_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX semantic_link_target_catalogue_item_idx ON core.semantic_link USING btree (target_multi_facet_aware_item_id);


--
-- Name: semanticlink_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX semanticlink_created_by_idx ON core.semantic_link USING btree (created_by);


--
-- Name: userimagefile_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX userimagefile_created_by_idx ON core.image_file USING btree (created_by);


--
-- Name: version_link_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX version_link_catalogue_item_idx ON core.version_link USING btree (multi_facet_aware_item_id);


--
-- Name: version_link_target_model_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX version_link_target_model_idx ON core.version_link USING btree (target_model_id);


--
-- Name: versionlink_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapperuser
--

CREATE INDEX versionlink_created_by_idx ON core.version_link USING btree (created_by);


--
-- Name: data_flow_source_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE INDEX data_flow_source_idx ON dataflow.data_flow USING btree (source_id);


--
-- Name: data_flow_target_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE INDEX data_flow_target_idx ON dataflow.data_flow USING btree (target_id);


--
-- Name: dataclasscomponent_created_by_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE INDEX dataclasscomponent_created_by_idx ON dataflow.data_class_component USING btree (created_by);


--
-- Name: dataelementcomponent_created_by_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE INDEX dataelementcomponent_created_by_idx ON dataflow.data_element_component USING btree (created_by);


--
-- Name: dataflow_created_by_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE INDEX dataflow_created_by_idx ON dataflow.data_flow USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON dataflow.flyway_schema_history USING btree (success);


--
-- Name: data_class_breadcrumb_tree_id_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_class_breadcrumb_tree_id_idx ON datamodel.data_class USING btree (breadcrumb_tree_id);


--
-- Name: data_class_data_model_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_class_data_model_idx ON datamodel.data_class USING btree (data_model_id);


--
-- Name: data_class_parent_data_class_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_class_parent_data_class_idx ON datamodel.data_class USING btree (parent_data_class_id);


--
-- Name: data_class_path_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_class_path_idx ON datamodel.data_class USING btree (path text_pattern_ops);


--
-- Name: data_element_breadcrumb_tree_id_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_element_breadcrumb_tree_id_idx ON datamodel.data_element USING btree (breadcrumb_tree_id);


--
-- Name: data_element_data_class_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_element_data_class_idx ON datamodel.data_element USING btree (data_class_id);


--
-- Name: data_element_data_type_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_element_data_type_idx ON datamodel.data_element USING btree (data_type_id);


--
-- Name: data_element_path_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_element_path_idx ON datamodel.data_element USING btree (path text_pattern_ops);


--
-- Name: data_model_branch_name_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_model_branch_name_idx ON datamodel.data_model USING btree (branch_name);


--
-- Name: data_model_breadcrumb_tree_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_model_breadcrumb_tree_idx ON datamodel.data_model USING btree (breadcrumb_tree_id);


--
-- Name: data_model_label_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_model_label_idx ON datamodel.data_model USING btree (label);


--
-- Name: data_model_model_version_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_model_model_version_idx ON datamodel.data_model USING btree (model_version);


--
-- Name: data_type_breadcrumb_tree_id_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_type_breadcrumb_tree_id_idx ON datamodel.data_type USING btree (breadcrumb_tree_id);


--
-- Name: data_type_data_model_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_type_data_model_idx ON datamodel.data_type USING btree (data_model_id);


--
-- Name: data_type_path_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX data_type_path_idx ON datamodel.data_type USING btree (path text_pattern_ops);


--
-- Name: dataclass_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX dataclass_created_by_idx ON datamodel.data_class USING btree (created_by);


--
-- Name: dataelement_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX dataelement_created_by_idx ON datamodel.data_element USING btree (created_by);


--
-- Name: datamodel_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX datamodel_created_by_idx ON datamodel.data_model USING btree (created_by);


--
-- Name: datatype_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX datatype_created_by_idx ON datamodel.data_type USING btree (created_by);


--
-- Name: enumeration_value_breadcrumb_tree_id_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX enumeration_value_breadcrumb_tree_id_idx ON datamodel.enumeration_value USING btree (breadcrumb_tree_id);


--
-- Name: enumeration_value_enumeration_type_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX enumeration_value_enumeration_type_idx ON datamodel.enumeration_value USING btree (enumeration_type_id);


--
-- Name: enumeration_value_path_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX enumeration_value_path_idx ON datamodel.enumeration_value USING btree (path text_pattern_ops);


--
-- Name: enumerationvalue_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX enumerationvalue_created_by_idx ON datamodel.enumeration_value USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON datamodel.flyway_schema_history USING btree (success);


--
-- Name: join_dataclass_to_facet_annotation_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_annotation_idx ON datamodel.join_dataclass_to_facet USING btree (annotation_id);


--
-- Name: join_dataclass_to_facet_classifier_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_classifier_idx ON datamodel.join_dataclass_to_facet USING btree (classifier_id);


--
-- Name: join_dataclass_to_facet_dataclass_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_dataclass_idx ON datamodel.join_dataclass_to_facet USING btree (dataclass_id);


--
-- Name: join_dataclass_to_facet_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_metadata_idx ON datamodel.join_dataclass_to_facet USING btree (metadata_id);


--
-- Name: join_dataclass_to_facet_reference_file_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_reference_file_idx ON datamodel.join_dataclass_to_facet USING btree (reference_file_id);


--
-- Name: join_dataclass_to_facet_rule_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_rule_idx ON datamodel.join_dataclass_to_facet USING btree (rule_id);


--
-- Name: join_dataclass_to_facet_semantic_link_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_semantic_link_idx ON datamodel.join_dataclass_to_facet USING btree (semantic_link_id);


--
-- Name: join_dataclass_to_facet_summary_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_facet_summary_metadata_idx ON datamodel.join_dataclass_to_facet USING btree (summary_metadata_id);


--
-- Name: join_dataclass_to_imported_data_element_imported_de_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataclass_to_imported_data_element_imported_de_idx ON datamodel.join_dataclass_to_imported_data_element USING btree (imported_dataelement_id);


--
-- Name: join_dataelement_to_facet_annotation_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_annotation_idx ON datamodel.join_dataelement_to_facet USING btree (annotation_id);


--
-- Name: join_dataelement_to_facet_classifier_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_classifier_idx ON datamodel.join_dataelement_to_facet USING btree (classifier_id);


--
-- Name: join_dataelement_to_facet_dataelement_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_dataelement_idx ON datamodel.join_dataelement_to_facet USING btree (dataelement_id);


--
-- Name: join_dataelement_to_facet_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_metadata_idx ON datamodel.join_dataelement_to_facet USING btree (metadata_id);


--
-- Name: join_dataelement_to_facet_reference_file_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_reference_file_idx ON datamodel.join_dataelement_to_facet USING btree (reference_file_id);


--
-- Name: join_dataelement_to_facet_rule_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_rule_idx ON datamodel.join_dataelement_to_facet USING btree (rule_id);


--
-- Name: join_dataelement_to_facet_semantic_link_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_semantic_link_idx ON datamodel.join_dataelement_to_facet USING btree (semantic_link_id);


--
-- Name: join_dataelement_to_facet_summary_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_dataelement_to_facet_summary_metadata_idx ON datamodel.join_dataelement_to_facet USING btree (summary_metadata_id);


--
-- Name: join_datamodel_to_facet_annotation_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_annotation_idx ON datamodel.join_datamodel_to_facet USING btree (annotation_id);


--
-- Name: join_datamodel_to_facet_classifier_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_classifier_idx ON datamodel.join_datamodel_to_facet USING btree (classifier_id);


--
-- Name: join_datamodel_to_facet_datamodel_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_datamodel_idx ON datamodel.join_datamodel_to_facet USING btree (datamodel_id);


--
-- Name: join_datamodel_to_facet_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_metadata_idx ON datamodel.join_datamodel_to_facet USING btree (metadata_id);


--
-- Name: join_datamodel_to_facet_reference_file_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_reference_file_idx ON datamodel.join_datamodel_to_facet USING btree (reference_file_id);


--
-- Name: join_datamodel_to_facet_rule_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_rule_idx ON datamodel.join_datamodel_to_facet USING btree (rule_id);


--
-- Name: join_datamodel_to_facet_semantic_link_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_semantic_link_idx ON datamodel.join_datamodel_to_facet USING btree (semantic_link_id);


--
-- Name: join_datamodel_to_facet_summary_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_summary_metadata_idx ON datamodel.join_datamodel_to_facet USING btree (summary_metadata_id);


--
-- Name: join_datamodel_to_facet_version_link_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_facet_version_link_idx ON datamodel.join_datamodel_to_facet USING btree (version_link_id);


--
-- Name: join_datamodel_to_imported_data_class_imported_dataclass_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datamodel_to_imported_data_class_imported_dataclass_idx ON datamodel.join_datamodel_to_imported_data_class USING btree (imported_dataclass_id);


--
-- Name: join_datatype_to_facet_annotation_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_annotation_idx ON datamodel.join_datatype_to_facet USING btree (annotation_id);


--
-- Name: join_datatype_to_facet_classifier_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_classifier_idx ON datamodel.join_datatype_to_facet USING btree (classifier_id);


--
-- Name: join_datatype_to_facet_datatype_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_datatype_idx ON datamodel.join_datatype_to_facet USING btree (datatype_id);


--
-- Name: join_datatype_to_facet_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_metadata_idx ON datamodel.join_datatype_to_facet USING btree (metadata_id);


--
-- Name: join_datatype_to_facet_reference_file_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_reference_file_idx ON datamodel.join_datatype_to_facet USING btree (reference_file_id);


--
-- Name: join_datatype_to_facet_rule_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_rule_idx ON datamodel.join_datatype_to_facet USING btree (rule_id);


--
-- Name: join_datatype_to_facet_semantic_link_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_semantic_link_idx ON datamodel.join_datatype_to_facet USING btree (semantic_link_id);


--
-- Name: join_datatype_to_facet_summary_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_datatype_to_facet_summary_metadata_idx ON datamodel.join_datatype_to_facet USING btree (summary_metadata_id);


--
-- Name: join_enumerationvalue_to_facet_annotation_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_enumerationvalue_to_facet_annotation_idx ON datamodel.join_enumerationvalue_to_facet USING btree (annotation_id);


--
-- Name: join_enumerationvalue_to_facet_classifier_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_enumerationvalue_to_facet_classifier_idx ON datamodel.join_enumerationvalue_to_facet USING btree (classifier_id);


--
-- Name: join_enumerationvalue_to_facet_enumerationvalue_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_enumerationvalue_to_facet_enumerationvalue_idx ON datamodel.join_enumerationvalue_to_facet USING btree (enumerationvalue_id);


--
-- Name: join_enumerationvalue_to_facet_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_enumerationvalue_to_facet_metadata_idx ON datamodel.join_enumerationvalue_to_facet USING btree (metadata_id);


--
-- Name: join_enumerationvalue_to_facet_reference_file_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_enumerationvalue_to_facet_reference_file_idx ON datamodel.join_enumerationvalue_to_facet USING btree (reference_file_id);


--
-- Name: join_enumerationvalue_to_facet_rule_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_enumerationvalue_to_facet_rule_idx ON datamodel.join_enumerationvalue_to_facet USING btree (rule_id);


--
-- Name: join_enumerationvalue_to_facet_semantic_link_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX join_enumerationvalue_to_facet_semantic_link_idx ON datamodel.join_enumerationvalue_to_facet USING btree (semantic_link_id);


--
-- Name: reference_type_reference_class_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX reference_type_reference_class_idx ON datamodel.data_type USING btree (reference_class_id);


--
-- Name: summary_metadata_report_summary_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX summary_metadata_report_summary_metadata_idx ON datamodel.summary_metadata_report USING btree (summary_metadata_id);


--
-- Name: summarymetadata_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX summarymetadata_created_by_idx ON datamodel.summary_metadata USING btree (created_by);


--
-- Name: summarymetadatareport_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapperuser
--

CREATE INDEX summarymetadatareport_created_by_idx ON datamodel.summary_metadata_report USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: federation; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON federation.flyway_schema_history USING btree (success);


--
-- Name: subscribed_model_local_model_id; Type: INDEX; Schema: federation; Owner: maurodatamapperuser
--

CREATE INDEX subscribed_model_local_model_id ON federation.subscribed_model USING btree (local_model_id);


--
-- Name: subscribed_model_subscribed_catalogue_id; Type: INDEX; Schema: federation; Owner: maurodatamapperuser
--

CREATE INDEX subscribed_model_subscribed_catalogue_id ON federation.subscribed_model USING btree (subscribed_catalogue_id);


--
-- Name: authorizationendpointparameters_created_by_idx; Type: INDEX; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE INDEX authorizationendpointparameters_created_by_idx ON openidconnect.authorization_endpoint_parameters USING btree (created_by);


--
-- Name: discoverydocument_created_by_idx; Type: INDEX; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE INDEX discoverydocument_created_by_idx ON openidconnect.discovery_document USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON openidconnect.flyway_schema_history USING btree (success);


--
-- Name: openidconnectprovider_created_by_idx; Type: INDEX; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE INDEX openidconnectprovider_created_by_idx ON openidconnect.openid_connect_provider USING btree (created_by);


--
-- Name: openidconnecttoken_created_by_idx; Type: INDEX; Schema: openidconnect; Owner: maurodatamapperuser
--

CREATE INDEX openidconnecttoken_created_by_idx ON openidconnect.openid_connect_token USING btree (created_by);


--
-- Name: data_element_data_type_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX data_element_data_type_idx ON referencedata.reference_data_element USING btree (reference_data_type_id);


--
-- Name: data_element_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX data_element_reference_data_model_idx ON referencedata.reference_data_element USING btree (reference_data_model_id);


--
-- Name: data_type_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX data_type_reference_data_model_idx ON referencedata.reference_data_type USING btree (reference_data_model_id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON referencedata.flyway_schema_history USING btree (success);


--
-- Name: reference_data_value_reference_data_element_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX reference_data_value_reference_data_element_idx ON referencedata.reference_data_value USING btree (reference_data_element_id);


--
-- Name: reference_data_value_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX reference_data_value_reference_data_model_idx ON referencedata.reference_data_value USING btree (reference_data_model_id);


--
-- Name: referencedataelement_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX referencedataelement_created_by_idx ON referencedata.reference_data_element USING btree (created_by);


--
-- Name: referencedatamodel_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX referencedatamodel_created_by_idx ON referencedata.reference_data_model USING btree (created_by);


--
-- Name: referencedatatype_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX referencedatatype_created_by_idx ON referencedata.reference_data_type USING btree (created_by);


--
-- Name: referenceenumerationvalue_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX referenceenumerationvalue_created_by_idx ON referencedata.reference_enumeration_value USING btree (created_by);


--
-- Name: referencesummarymetadata_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX referencesummarymetadata_created_by_idx ON referencedata.reference_summary_metadata USING btree (created_by);


--
-- Name: referencesummarymetadatareport_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX referencesummarymetadatareport_created_by_idx ON referencedata.reference_summary_metadata_report USING btree (created_by);


--
-- Name: summary_metadata_report_summary_metadata_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapperuser
--

CREATE INDEX summary_metadata_report_summary_metadata_idx ON referencedata.reference_summary_metadata_report USING btree (summary_metadata_id);


--
-- Name: apikey_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX apikey_created_by_idx ON security.api_key USING btree (created_by);


--
-- Name: catalogue_user_profile_picture_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX catalogue_user_profile_picture_idx ON security.catalogue_user USING btree (profile_picture_id);


--
-- Name: catalogueuser_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX catalogueuser_created_by_idx ON security.catalogue_user USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON security.flyway_schema_history USING btree (success);


--
-- Name: grouprole_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX grouprole_created_by_idx ON security.group_role USING btree (created_by);


--
-- Name: jcutug_catalogue_user_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX jcutug_catalogue_user_idx ON security.join_catalogue_user_to_user_group USING btree (catalogue_user_id);


--
-- Name: jcutug_user_group_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX jcutug_user_group_idx ON security.join_catalogue_user_to_user_group USING btree (user_group_id);


--
-- Name: securableresourcegrouprole_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX securableresourcegrouprole_created_by_idx ON security.securable_resource_group_role USING btree (created_by);


--
-- Name: usergroup_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapperuser
--

CREATE INDEX usergroup_created_by_idx ON security.user_group USING btree (created_by);


--
-- Name: code_set_branch_name_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX code_set_branch_name_idx ON terminology.code_set USING btree (branch_name);


--
-- Name: code_set_breadcrumb_tree_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX code_set_breadcrumb_tree_idx ON terminology.code_set USING btree (breadcrumb_tree_id);


--
-- Name: code_set_folder_id_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX code_set_folder_id_idx ON terminology.code_set USING btree (folder_id);


--
-- Name: code_set_label_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX code_set_label_idx ON terminology.code_set USING btree (label);


--
-- Name: code_set_model_version_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX code_set_model_version_idx ON terminology.code_set USING btree (model_version);


--
-- Name: codeset_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX codeset_created_by_idx ON terminology.code_set USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX flyway_schema_history_s_idx ON terminology.flyway_schema_history USING btree (success);


--
-- Name: join_codeset_to_facet_annotation_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_annotation_idx ON terminology.join_codeset_to_facet USING btree (annotation_id);


--
-- Name: join_codeset_to_facet_classifier_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_classifier_idx ON terminology.join_codeset_to_facet USING btree (classifier_id);


--
-- Name: join_codeset_to_facet_codeset_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_codeset_idx ON terminology.join_codeset_to_facet USING btree (codeset_id);


--
-- Name: join_codeset_to_facet_metadata_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_metadata_idx ON terminology.join_codeset_to_facet USING btree (metadata_id);


--
-- Name: join_codeset_to_facet_reference_file_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_reference_file_idx ON terminology.join_codeset_to_facet USING btree (reference_file_id);


--
-- Name: join_codeset_to_facet_rule_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_rule_idx ON terminology.join_codeset_to_facet USING btree (rule_id);


--
-- Name: join_codeset_to_facet_semantic_link_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_semantic_link_idx ON terminology.join_codeset_to_facet USING btree (semantic_link_id);


--
-- Name: join_codeset_to_facet_version_link_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_facet_version_link_idx ON terminology.join_codeset_to_facet USING btree (version_link_id);


--
-- Name: join_codeset_to_term_codeset_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_term_codeset_idx ON terminology.join_codeset_to_term USING btree (codeset_id);


--
-- Name: join_codeset_to_term_term_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_codeset_to_term_term_idx ON terminology.join_codeset_to_term USING btree (term_id);


--
-- Name: join_term_to_facet_annotation_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_term_to_facet_annotation_idx ON terminology.join_term_to_facet USING btree (annotation_id);


--
-- Name: join_term_to_facet_classifier_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_term_to_facet_classifier_idx ON terminology.join_term_to_facet USING btree (classifier_id);


--
-- Name: join_term_to_facet_metadata_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_term_to_facet_metadata_idx ON terminology.join_term_to_facet USING btree (metadata_id);


--
-- Name: join_term_to_facet_reference_file_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_term_to_facet_reference_file_idx ON terminology.join_term_to_facet USING btree (reference_file_id);


--
-- Name: join_term_to_facet_rule_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_term_to_facet_rule_idx ON terminology.join_term_to_facet USING btree (rule_id);


--
-- Name: join_term_to_facet_semantic_link_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_term_to_facet_semantic_link_idx ON terminology.join_term_to_facet USING btree (semantic_link_id);


--
-- Name: join_term_to_facet_term_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_term_to_facet_term_idx ON terminology.join_term_to_facet USING btree (term_id);


--
-- Name: join_terminology_to_facet_annotation_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_annotation_idx ON terminology.join_terminology_to_facet USING btree (annotation_id);


--
-- Name: join_terminology_to_facet_classifier_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_classifier_idx ON terminology.join_terminology_to_facet USING btree (classifier_id);


--
-- Name: join_terminology_to_facet_metadata_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_metadata_idx ON terminology.join_terminology_to_facet USING btree (metadata_id);


--
-- Name: join_terminology_to_facet_reference_file_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_reference_file_idx ON terminology.join_terminology_to_facet USING btree (reference_file_id);


--
-- Name: join_terminology_to_facet_rule_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_rule_idx ON terminology.join_terminology_to_facet USING btree (rule_id);


--
-- Name: join_terminology_to_facet_semantic_link_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_semantic_link_idx ON terminology.join_terminology_to_facet USING btree (semantic_link_id);


--
-- Name: join_terminology_to_facet_terminology_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_terminology_idx ON terminology.join_terminology_to_facet USING btree (terminology_id);


--
-- Name: join_terminology_to_facet_version_link_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX join_terminology_to_facet_version_link_idx ON terminology.join_terminology_to_facet USING btree (version_link_id);


--
-- Name: term_breadcrumb_tree_id_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_breadcrumb_tree_id_idx ON terminology.term USING btree (breadcrumb_tree_id);


--
-- Name: term_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_created_by_idx ON terminology.term USING btree (created_by);


--
-- Name: term_path_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_path_idx ON terminology.term USING btree (path text_pattern_ops);


--
-- Name: term_relationship_breadcrumb_tree_id_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_relationship_breadcrumb_tree_id_idx ON terminology.term_relationship USING btree (breadcrumb_tree_id);


--
-- Name: term_relationship_path_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_relationship_path_idx ON terminology.term_relationship USING btree (path text_pattern_ops);


--
-- Name: term_relationship_source_term_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_relationship_source_term_idx ON terminology.term_relationship USING btree (source_term_id);


--
-- Name: term_relationship_target_term_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_relationship_target_term_idx ON terminology.term_relationship USING btree (target_term_id);


--
-- Name: term_relationship_type_terminology_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_relationship_type_terminology_idx ON terminology.term_relationship_type USING btree (terminology_id);


--
-- Name: term_terminology_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX term_terminology_idx ON terminology.term USING btree (terminology_id);


--
-- Name: terminology_branch_name_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX terminology_branch_name_idx ON terminology.terminology USING btree (branch_name);


--
-- Name: terminology_breadcrumb_tree_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX terminology_breadcrumb_tree_idx ON terminology.terminology USING btree (breadcrumb_tree_id);


--
-- Name: terminology_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX terminology_created_by_idx ON terminology.terminology USING btree (created_by);


--
-- Name: terminology_folder_id_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX terminology_folder_id_idx ON terminology.terminology USING btree (folder_id);


--
-- Name: terminology_label_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX terminology_label_idx ON terminology.terminology USING btree (label);


--
-- Name: terminology_model_version_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX terminology_model_version_idx ON terminology.terminology USING btree (model_version);


--
-- Name: termrelationship_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX termrelationship_created_by_idx ON terminology.term_relationship USING btree (created_by);


--
-- Name: termrelationshiptype_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapperuser
--

CREATE INDEX termrelationshiptype_created_by_idx ON terminology.term_relationship_type USING btree (created_by);


--
-- Name: join_folder_to_facet fk14o06qtiem74ycw6896javux7; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fk14o06qtiem74ycw6896javux7 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: breadcrumb_tree fk1hraqwgiiva4reb2v6do4it81; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.breadcrumb_tree
    ADD CONSTRAINT fk1hraqwgiiva4reb2v6do4it81 FOREIGN KEY (parent_id) REFERENCES core.breadcrumb_tree(id) ON DELETE CASCADE;


--
-- Name: join_classifier_to_facet fk1yihq7q1hhwm3f7jn4g7isg5k; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk1yihq7q1hhwm3f7jn4g7isg5k FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_classifier_to_facet fk3h1hax9omk9o62119jsc45m35; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk3h1hax9omk9o62119jsc45m35 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_classifier_to_facet fk54j6lhkhnneag9rqsnchk9rwf; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk54j6lhkhnneag9rqsnchk9rwf FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: folder fk57g7veis1gp5wn3g0mp0x57pl; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT fk57g7veis1gp5wn3g0mp0x57pl FOREIGN KEY (parent_folder_id) REFERENCES core.folder(id);


--
-- Name: join_classifier_to_facet fk5owmrlff8c3f3bf2e7om5xkfj; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk5owmrlff8c3f3bf2e7om5xkfj FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_classifier_to_facet fk6531dcod746lwh2v7k4fatx7b; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk6531dcod746lwh2v7k4fatx7b FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_folder_to_facet fk6bgvwj5n9a92tkoky84uaktlm; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fk6bgvwj5n9a92tkoky84uaktlm FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: classifier fkahkm58kcer6a9q2v01ealovr6; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT fkahkm58kcer6a9q2v01ealovr6 FOREIGN KEY (parent_classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_versionedfolder_to_facet fkcdu99gvtth7g6q2glm329u7uu; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_versionedfolder_to_facet
    ADD CONSTRAINT fkcdu99gvtth7g6q2glm329u7uu FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_folder_to_facet fkibq4i08l0b0nkbopm8wjrdfd9; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkibq4i08l0b0nkbopm8wjrdfd9 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_folder_to_facet fkml4kb6cf0wr79sopbu6fglets; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkml4kb6cf0wr79sopbu6fglets FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: annotation fknrnwt8d2s4kytg7mis2rg2a5x; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.annotation
    ADD CONSTRAINT fknrnwt8d2s4kytg7mis2rg2a5x FOREIGN KEY (parent_annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_folder_to_facet fkohkkmadsw0xtk5qs2mx0y0npo; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkohkkmadsw0xtk5qs2mx0y0npo FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_classifier_to_facet fks9xsugq08k5ejrfha2540ups0; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fks9xsugq08k5ejrfha2540ups0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_versionedfolder_to_facet fksltt9c209xswibf8ocho4l8ly; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_versionedfolder_to_facet
    ADD CONSTRAINT fksltt9c209xswibf8ocho4l8ly FOREIGN KEY (versionedfolder_id) REFERENCES core.folder(id);


--
-- Name: join_folder_to_facet fksuj7eo7stfn56f1b0ci16uqc4; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fksuj7eo7stfn56f1b0ci16uqc4 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: rule_representation rule_representation_rule_id_fk; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapperuser
--

ALTER TABLE ONLY core.rule_representation
    ADD CONSTRAINT rule_representation_rule_id_fk FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataflow_to_facet fk18w0v8pjw1ejcppns1ovsaiuh; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk18w0v8pjw1ejcppns1ovsaiuh FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataelementcomponent_to_facet fk2458d1q7dlb53wk3i2f3tvn07; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fk2458d1q7dlb53wk3i2f3tvn07 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataflow_to_facet fk3desra9ff6a5m317j5emcbrb; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk3desra9ff6a5m317j5emcbrb FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_flow fk3fj19l4nvknojy3srxmkdfw5w; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fk3fj19l4nvknojy3srxmkdfw5w FOREIGN KEY (source_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataflow_to_facet fk4lftftotgkhj732e3cdofnua9; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk4lftftotgkhj732e3cdofnua9 FOREIGN KEY (dataflow_id) REFERENCES dataflow.data_flow(id);


--
-- Name: join_data_class_component_to_target_data_class fk5n8do09dd74fa9h1n73ovvule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_target_data_class
    ADD CONSTRAINT fk5n8do09dd74fa9h1n73ovvule FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_data_class_component_to_source_data_class fk69j2bufggb1whkshma276fb3u; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_source_data_class
    ADD CONSTRAINT fk69j2bufggb1whkshma276fb3u FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_dataflow_to_facet fk6i15t337ti18ejj9g11ntw7wa; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk6i15t337ti18ejj9g11ntw7wa FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataelementcomponent_to_facet fk6oar34bhid29tojvm1ukllq7t; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fk6oar34bhid29tojvm1ukllq7t FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_data_element_component_to_target_data_element fk75eg0xy6obhx83sahuf43ftkn; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_target_data_element
    ADD CONSTRAINT fk75eg0xy6obhx83sahuf43ftkn FOREIGN KEY (data_element_id) REFERENCES datamodel.data_element(id);


--
-- Name: data_flow fk77hjma5cdtsc07lk9axb9uplj; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fk77hjma5cdtsc07lk9axb9uplj FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataclasscomponent_to_facet fk83mqbv5ca5sjld100rbiymsvs; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fk83mqbv5ca5sjld100rbiymsvs FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_element_component fk8q670e83q94a20x8urckoqhs7; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT fk8q670e83q94a20x8urckoqhs7 FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: data_class_component fk8qu1p2ejn32fxvwbtqmcb28d4; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT fk8qu1p2ejn32fxvwbtqmcb28d4 FOREIGN KEY (data_flow_id) REFERENCES dataflow.data_flow(id);


--
-- Name: join_data_class_component_to_source_data_class fk8rlgnf224u6byjb9mutxvj02d; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_source_data_class
    ADD CONSTRAINT fk8rlgnf224u6byjb9mutxvj02d FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclasscomponent_to_facet fk9nd41ujgegfisr6s7prcxle75; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fk9nd41ujgegfisr6s7prcxle75 FOREIGN KEY (dataclasscomponent_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_dataelementcomponent_to_facet fkbcxohbk6botm68gguiqulgveq; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkbcxohbk6botm68gguiqulgveq FOREIGN KEY (dataelementcomponent_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: join_dataclasscomponent_to_facet fkdataclasscomponent_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkdataclasscomponent_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelementcomponent_to_facet fkdataelementcomponent_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkdataelementcomponent_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataflow_to_facet fkdataflow_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkdataflow_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataclasscomponent_to_facet fke3nbbi9b4igb936kcxlx9lcxd; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fke3nbbi9b4igb936kcxlx9lcxd FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_class_component fkevgs9u7n7x5tr0a32ce3br9pi; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT fkevgs9u7n7x5tr0a32ce3br9pi FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_data_element_component_to_source_data_element fkfj2dcm6f4pug84c27slqx72sb; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_source_data_element
    ADD CONSTRAINT fkfj2dcm6f4pug84c27slqx72sb FOREIGN KEY (data_element_component_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: join_dataclasscomponent_to_facet fki22diqv42nnrxmhyki9f8sodi; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fki22diqv42nnrxmhyki9f8sodi FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelementcomponent_to_facet fkj8cv4bqtulig1rg7f0xikfr2d; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkj8cv4bqtulig1rg7f0xikfr2d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataclasscomponent_to_facet fkjnu3epst826kd40f60ktimo6k; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkjnu3epst826kd40f60ktimo6k FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_data_class_component_to_target_data_class fkjp8k503bbqqe4h6s0f7uygg8n; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_target_data_class
    ADD CONSTRAINT fkjp8k503bbqqe4h6s0f7uygg8n FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: data_flow fkl8uawgeg58jq51ydqqddm5d7g; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fkl8uawgeg58jq51ydqqddm5d7g FOREIGN KEY (target_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataclasscomponent_to_facet fkmfkn6if9k5q1k938jr5mx2lhw; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkmfkn6if9k5q1k938jr5mx2lhw FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataelementcomponent_to_facet fknf8wevvjjhglny27yn1yoav83; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fknf8wevvjjhglny27yn1yoav83 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_data_element_component_to_source_data_element fknmiwa6fd5ohwd00f0sk0wfx3t; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_source_data_element
    ADD CONSTRAINT fknmiwa6fd5ohwd00f0sk0wfx3t FOREIGN KEY (data_element_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_data_element_component_to_target_data_element fko677lt6vljfo4mcjbhn0y4bf6; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_target_data_element
    ADD CONSTRAINT fko677lt6vljfo4mcjbhn0y4bf6 FOREIGN KEY (data_element_component_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: data_element_component fkpfgnmog9cl0w1lmqoor55xq3p; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT fkpfgnmog9cl0w1lmqoor55xq3p FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataflow_to_facet fkpvp8i5ner679uom2d32bu59f7; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkpvp8i5ner679uom2d32bu59f7 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataflow_to_facet fkpwwfp2jwv5f5kwascasa113r1; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkpwwfp2jwv5f5kwascasa113r1 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelementcomponent_to_facet fkrs6wh8ahehpma0s81ysqruvgp; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapperuser
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkrs6wh8ahehpma0s81ysqruvgp FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_datamodel_to_facet fk1ek18e3t2cki6fch7jmbbati0; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fk1ek18e3t2cki6fch7jmbbati0 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_datamodel_to_facet fk1yt7axbg37bynceoy6p06a5pk; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fk1yt7axbg37bynceoy6p06a5pk FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: data_class fk27usn28pto0b239mwltrfmksg; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk27usn28pto0b239mwltrfmksg FOREIGN KEY (data_model_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_enumerationvalue_to_facet fk40tuyaalgpyfdnp2wqfl1bl3b; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fk40tuyaalgpyfdnp2wqfl1bl3b FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_class fk4yr99q0xt49n31x48e78do1rq; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk4yr99q0xt49n31x48e78do1rq FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataclass_to_extended_data_class fk5cn7jgi02lejlubi97a3x17ar; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_extended_data_class
    ADD CONSTRAINT fk5cn7jgi02lejlubi97a3x17ar FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fk5n6b907728hblnk0ihhwhbac4; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fk5n6b907728hblnk0ihhwhbac4 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_model fk5vqrag93xcmptnduomuj1d5up; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fk5vqrag93xcmptnduomuj1d5up FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_datatype_to_facet fk685o5rkte9js4kibmx3e201ul; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fk685o5rkte9js4kibmx3e201ul FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_element fk6e7wo4o9bw27vk32roeo91cyn; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fk6e7wo4o9bw27vk32roeo91cyn FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: data_class fk71lrhqamsxh1b57sbigrgonq2; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk71lrhqamsxh1b57sbigrgonq2 FOREIGN KEY (parent_data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fk7tq9mj4pasf5fmebs2sc9ap86; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fk7tq9mj4pasf5fmebs2sc9ap86 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_element fk86to96ckvjf64qlwvosltcnsm; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fk86to96ckvjf64qlwvosltcnsm FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataelement_to_facet fk89immwtwlrbwrel10gjy3yimw; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fk89immwtwlrbwrel10gjy3yimw FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataclass_to_imported_data_class fk8bf683fj07ef7q6ua9ax5sipb; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_class
    ADD CONSTRAINT fk8bf683fj07ef7q6ua9ax5sipb FOREIGN KEY (imported_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataelement_to_facet fk8roq23ibhwodnpibdp1srk6aq; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fk8roq23ibhwodnpibdp1srk6aq FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: summary_metadata_report fk9auhycixx3nly0xthx9eg8i8y; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.summary_metadata_report
    ADD CONSTRAINT fk9auhycixx3nly0xthx9eg8i8y FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_enumerationvalue_to_facet fk9xuiuctli6j5hra8j0pw0xbib; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fk9xuiuctli6j5hra8j0pw0xbib FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_model fk9ybmrposbekl2h5pnwet4fx30; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fk9ybmrposbekl2h5pnwet4fx30 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: enumeration_value fkam3sx31p5a0eap02h4iu1nwsg; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT fkam3sx31p5a0eap02h4iu1nwsg FOREIGN KEY (enumeration_type_id) REFERENCES datamodel.data_type(id);


--
-- Name: join_dataclass_to_extended_data_class fkaph92y3qdyublukjj8mbsivo3; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_extended_data_class
    ADD CONSTRAINT fkaph92y3qdyublukjj8mbsivo3 FOREIGN KEY (extended_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_imported_data_element fkaywt9cf9pam7w7ieo2kyv64sb; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_element
    ADD CONSTRAINT fkaywt9cf9pam7w7ieo2kyv64sb FOREIGN KEY (imported_dataelement_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_datamodel_to_facet fkb1rfqfx6stfaote1vqbh0u65b; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkb1rfqfx6stfaote1vqbh0u65b FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_datamodel_to_facet fkb2bggjawxcb5pynsrnpwgw35q; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkb2bggjawxcb5pynsrnpwgw35q FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_datamodel_to_imported_data_type fkbax3mbjn9u65ahhb5t782hq7y; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_type
    ADD CONSTRAINT fkbax3mbjn9u65ahhb5t782hq7y FOREIGN KEY (imported_datatype_id) REFERENCES datamodel.data_type(id);


--
-- Name: data_type fkbqs2sknmwe6i3rtwrhflk9s5n; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fkbqs2sknmwe6i3rtwrhflk9s5n FOREIGN KEY (data_model_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataclass_to_facet fkc80l2pkf48a8sw4ijsudyaers; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkc80l2pkf48a8sw4ijsudyaers FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fkdataclass_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkdataclass_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelement_to_facet fkdataelement_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkdataelement_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_datamodel_to_facet fkdatamodel_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkdatamodel_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_datatype_to_facet fkdatatype_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkdatatype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelement_to_facet fkdn8e1l2pofwmdpfroe9bkhskm; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkdn8e1l2pofwmdpfroe9bkhskm FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelement_to_facet fke75uuv2w694ofrm1ogdqio495; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fke75uuv2w694ofrm1ogdqio495 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_enumerationvalue_to_facet fkenumerationvalue_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkenumerationvalue_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataclass_to_facet fkewipna2xjervio2w9rsem7vvu; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkewipna2xjervio2w9rsem7vvu FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_enumerationvalue_to_facet fkf8d99ketatffxmapoax1upmo8; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkf8d99ketatffxmapoax1upmo8 FOREIGN KEY (enumerationvalue_id) REFERENCES datamodel.enumeration_value(id);


--
-- Name: join_dataelement_to_facet fkg58co9t99dfp0076vkn23hemy; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkg58co9t99dfp0076vkn23hemy FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataclass_to_facet fkgeoshkis2b6trtu8c5etvg72n; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkgeoshkis2b6trtu8c5etvg72n FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_datatype_to_facet fkgfuqffr58ihdup07r1ys2rsts; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkgfuqffr58ihdup07r1ys2rsts FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_dataclass_to_facet fkgh9f6ok7n9wxwxopjku7yhfea; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkgh9f6ok7n9wxwxopjku7yhfea FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_datamodel_to_imported_data_class fkhlnup269u21f4tvdkt9sshg51; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_class
    ADD CONSTRAINT fkhlnup269u21f4tvdkt9sshg51 FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_datamodel_to_facet fkicjxoyym4mvpajl7amd2c96vg; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkicjxoyym4mvpajl7amd2c96vg FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_enumerationvalue_to_facet fkissxtxxag5rkhtjr2q1pivt64; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkissxtxxag5rkhtjr2q1pivt64 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: enumeration_value fkj6s22vawbgx8qbi6u95umov5t; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT fkj6s22vawbgx8qbi6u95umov5t FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_datatype_to_facet fkk6htfwfpc5ty1o1skmlw0ct5h; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkk6htfwfpc5ty1o1skmlw0ct5h FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_datamodel_to_facet fkk8m8u0b9dd216qsjdkbbttqmu; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkk8m8u0b9dd216qsjdkbbttqmu FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_datatype_to_facet fkka92tyn95wh23p9y7rjb1sila; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkka92tyn95wh23p9y7rjb1sila FOREIGN KEY (datatype_id) REFERENCES datamodel.data_type(id);


--
-- Name: data_model fkkq5e5fj5kdb737ktmhyyljy4e; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fkkq5e5fj5kdb737ktmhyyljy4e FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_datamodel_to_facet fkn8kvp5hpmtpu6t9ivldafifom; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkn8kvp5hpmtpu6t9ivldafifom FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_element fkncb91jl5cylo6nmoolmkif0y4; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fkncb91jl5cylo6nmoolmkif0y4 FOREIGN KEY (data_type_id) REFERENCES datamodel.data_type(id);


--
-- Name: join_datamodel_to_imported_data_class fkp7q1ry4kxlgldr6vtdqai1bns; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_class
    ADD CONSTRAINT fkp7q1ry4kxlgldr6vtdqai1bns FOREIGN KEY (imported_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_imported_data_element fkppmuveyr38fys2lw45kkp8n0s; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_element
    ADD CONSTRAINT fkppmuveyr38fys2lw45kkp8n0s FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datamodel_to_facet fkppqku5drbeh06ro6594sx7qpn; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkppqku5drbeh06ro6594sx7qpn FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_dataclass_to_facet fkpqpxtrqg9jh2ick2ug9mhcfxt; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkpqpxtrqg9jh2ick2ug9mhcfxt FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataelement_to_facet fkpsyiacoeuww886wy5apt5idwq; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkpsyiacoeuww886wy5apt5idwq FOREIGN KEY (dataelement_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_datatype_to_facet fkq73nqfoqdhodobkio53xnoroj; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkq73nqfoqdhodobkio53xnoroj FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelement_to_facet fkqef1ustdtk1irqjnohxwhlsxf; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkqef1ustdtk1irqjnohxwhlsxf FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_enumerationvalue_to_facet fkrefs16rh5cjm8rwngb9ijw9y1; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkrefs16rh5cjm8rwngb9ijw9y1 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_type fkribr7hv9shypnj2iru0hsx2sn; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fkribr7hv9shypnj2iru0hsx2sn FOREIGN KEY (reference_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datatype_to_facet fks3obp3gh2qp7lvl7c2ke33672; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fks3obp3gh2qp7lvl7c2ke33672 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_datamodel_to_imported_data_type fks8icj3nlbxt8bnrtnhpo81lg2; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_type
    ADD CONSTRAINT fks8icj3nlbxt8bnrtnhpo81lg2 FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: data_type fksiu83nftgdvb7kdvaik9fghsj; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fksiu83nftgdvb7kdvaik9fghsj FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_enumerationvalue_to_facet fkso04vaqmba4n4ffdbx5gg0fly; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkso04vaqmba4n4ffdbx5gg0fly FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataclass_to_imported_data_class fktfwuhg9cda52duj50ocsed0cl; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_class
    ADD CONSTRAINT fktfwuhg9cda52duj50ocsed0cl FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datatype_to_facet fkxyctuwpfqyqog98xf69enu2y; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapperuser
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkxyctuwpfqyqog98xf69enu2y FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: openid_connect_provider fk5gelp5vivw7w8ruishcfow0dk; Type: FK CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_provider
    ADD CONSTRAINT fk5gelp5vivw7w8ruishcfow0dk FOREIGN KEY (discovery_document_id) REFERENCES openidconnect.discovery_document(id);


--
-- Name: openid_connect_provider fklwbbxbxnppnq16wir9lb2mmb5; Type: FK CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_provider
    ADD CONSTRAINT fklwbbxbxnppnq16wir9lb2mmb5 FOREIGN KEY (authorization_endpoint_parameters_id) REFERENCES openidconnect.authorization_endpoint_parameters(id);


--
-- Name: openid_connect_token fkpap35aly7ud3siorrhvclyc7n; Type: FK CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_token
    ADD CONSTRAINT fkpap35aly7ud3siorrhvclyc7n FOREIGN KEY (openid_connect_provider_id) REFERENCES openidconnect.openid_connect_provider(id);


--
-- Name: openid_connect_token fkqdl6u342dsg6xnmruqdg3lnaq; Type: FK CONSTRAINT; Schema: openidconnect; Owner: maurodatamapperuser
--

ALTER TABLE ONLY openidconnect.openid_connect_token
    ADD CONSTRAINT fkqdl6u342dsg6xnmruqdg3lnaq FOREIGN KEY (catalogue_user_id) REFERENCES security.catalogue_user(id);


--
-- Name: reference_data_type fk21bionqtblyjus0xdx0fpxsd0; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT fk21bionqtblyjus0xdx0fpxsd0 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referenceenumerationvalue_to_facet fk2cfjn7dvabjkphwvne3jmhu24; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fk2cfjn7dvabjkphwvne3jmhu24 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_referencedataelement_to_facet fk2fki0p2nnwaurehb5cjttuvix; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fk2fki0p2nnwaurehb5cjttuvix FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_referencedataelement_to_facet fk2ls8wxo2ymrl7lpcys7j0xv3b; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fk2ls8wxo2ymrl7lpcys7j0xv3b FOREIGN KEY (referencedataelement_id) REFERENCES referencedata.reference_data_element(id);


--
-- Name: join_referencedatamodel_to_facet fk3jbl1c288a9m1wp6hpira3esu; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk3jbl1c288a9m1wp6hpira3esu FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: reference_data_value fk3ru68cbfsr7cx03c1szowx23u; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT fk3ru68cbfsr7cx03c1szowx23u FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referencedatatype_to_facet fk3vwe6oyjkdap164w7imcng9vx; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fk3vwe6oyjkdap164w7imcng9vx FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: reference_data_element fk5s8ym98wxlmji2cwd5c2uqx51; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fk5s8ym98wxlmji2cwd5c2uqx51 FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: reference_data_element fk72aidiwlq9doq630milqmpt0h; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fk72aidiwlq9doq630milqmpt0h FOREIGN KEY (reference_data_type_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: join_referencedatatype_to_facet fk7j8ag77c03icvomcohocy682d; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fk7j8ag77c03icvomcohocy682d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_data_model fk7jnsebhp01jrvj1cnoiglnk36; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fk7jnsebhp01jrvj1cnoiglnk36 FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_referenceenumerationvalue_to_facet fk87toxbm4bddbchculnipo9876; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fk87toxbm4bddbchculnipo9876 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: reference_data_model fk8dvr6bt8lf5xtces9vstu3h9i; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fk8dvr6bt8lf5xtces9vstu3h9i FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_referencedatamodel_to_facet fk8gio5kn4wbjxsb3vpxno2guty; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk8gio5kn4wbjxsb3vpxno2guty FOREIGN KEY (referencedatamodel_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referencedatamodel_to_facet fk8jwrx0ncwyb64s7d9ygmjr2f7; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk8jwrx0ncwyb64s7d9ygmjr2f7 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedatatype_to_facet fkag55g7g8434y1497a6jmldxlr; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkag55g7g8434y1497a6jmldxlr FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedataelement_to_facet fkb7mrla3ru59iox823w8cgdiy0; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkb7mrla3ru59iox823w8cgdiy0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedatatype_to_facet fkbw5w6fr1vaf9v0pcu7qs81nvu; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkbw5w6fr1vaf9v0pcu7qs81nvu FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkclc83k4qxd0yxfspwkkttsjmj; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkclc83k4qxd0yxfspwkkttsjmj FOREIGN KEY (referenceenumerationvalue_id) REFERENCES referencedata.reference_enumeration_value(id);


--
-- Name: join_referencedataelement_to_facet fkd3a65vscren7g42xw4rahy6g5; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkd3a65vscren7g42xw4rahy6g5 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_enumeration_value fkdh4kk2d1frpb2rfep76o7d6v8; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT fkdh4kk2d1frpb2rfep76o7d6v8 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkemx1xs8y5xnl1a6kdu18mp3us; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkemx1xs8y5xnl1a6kdu18mp3us FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedataelement_to_facet fketu75lbeuhiookwn6qawi4coq; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fketu75lbeuhiookwn6qawi4coq FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_enumeration_value fkfcsl5wvgo4hhgd32kio4vsxke; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT fkfcsl5wvgo4hhgd32kio4vsxke FOREIGN KEY (reference_enumeration_type_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: reference_data_element fkfmyjc00b03urjiavamg30vryh; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fkfmyjc00b03urjiavamg30vryh FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referencedatatype_to_facet fkggbf0ml2ou4b2k525xrb1mxq6; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkggbf0ml2ou4b2k525xrb1mxq6 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedatamodel_to_facet fkjiqw3v6crj988n5addti0ar4u; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkjiqw3v6crj988n5addti0ar4u FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_data_model fkk0dbj4ejwa3rpnm87ten7l650; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fkk0dbj4ejwa3rpnm87ten7l650 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referencedatamodel_to_facet fkksgi9yaaa427xe5saynb6rd2i; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkksgi9yaaa427xe5saynb6rd2i FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedatamodel_to_facet fkmn7qjcevpmoeq4rtudux34by; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkmn7qjcevpmoeq4rtudux34by FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_data_type fkn6ied2qohp1b9guvwcsskng2b; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT fkn6ied2qohp1b9guvwcsskng2b FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkp2io00cx587eojmbl5v27g7m3; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkp2io00cx587eojmbl5v27g7m3 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_referencedatamodel_to_facet fkpq9dfcuckjwcdeh9n54r062e0; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkpq9dfcuckjwcdeh9n54r062e0 FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkq50iqxdtfqwh3x6mdaepsx143; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkq50iqxdtfqwh3x6mdaepsx143 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedatatype_to_facet fkqaa9kx536h4hsp7prrv01ouay; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkqaa9kx536h4hsp7prrv01ouay FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: join_referencedataelement_to_facet fkqp0ri5bm3hvss6s1j3pyonkxr; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkqp0ri5bm3hvss6s1j3pyonkxr FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedataelement_to_facet fkreferencedataelement_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkreferencedataelement_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedatamodel_to_facet fkreferencedatamodel_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkreferencedatamodel_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedatatype_to_facet fkreferencedatatype_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkreferencedatatype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkreferenceenumerationvalue_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkreferenceenumerationvalue_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedataelement_to_facet fkrltsh3bwdh88lysiui0euxus8; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkrltsh3bwdh88lysiui0euxus8 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedatatype_to_facet fkser4c5ad6dkspbnyjl2r1yuj3; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkser4c5ad6dkspbnyjl2r1yuj3 FOREIGN KEY (referencedatatype_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: join_referencedatamodel_to_facet fktlkajagcv38bnatcquinb7p2v; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fktlkajagcv38bnatcquinb7p2v FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: reference_summary_metadata_report fktm1k29089tgksd63i7yjaha8g; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_summary_metadata_report
    ADD CONSTRAINT fktm1k29089tgksd63i7yjaha8g FOREIGN KEY (summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_data_value fkuknlrsbwja5t5vd84ceulvn9p; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapperuser
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT fkuknlrsbwja5t5vd84ceulvn9p FOREIGN KEY (reference_data_element_id) REFERENCES referencedata.reference_data_element(id);


--
-- Name: group_role fk9y8ew5lpksnila4b7g56xcl1n; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT fk9y8ew5lpksnila4b7g56xcl1n FOREIGN KEY (parent_id) REFERENCES security.group_role(id);


--
-- Name: join_catalogue_user_to_user_group fkauyvlits5bug2jc362csx3m18; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT fkauyvlits5bug2jc362csx3m18 FOREIGN KEY (user_group_id) REFERENCES security.user_group(id);


--
-- Name: securable_resource_group_role fkdjitehknypyvc8rjpeiw9ri97; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT fkdjitehknypyvc8rjpeiw9ri97 FOREIGN KEY (user_group_id) REFERENCES security.user_group(id);


--
-- Name: securable_resource_group_role fkgxkys8feqb0jvmshenxe7hvig; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT fkgxkys8feqb0jvmshenxe7hvig FOREIGN KEY (group_role_id) REFERENCES security.group_role(id);


--
-- Name: api_key fkl8s3q1v3lg1crjh3kmqqbiwcu; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT fkl8s3q1v3lg1crjh3kmqqbiwcu FOREIGN KEY (catalogue_user_id) REFERENCES security.catalogue_user(id);


--
-- Name: user_group fknfw9gxi505amomyyy78665950; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT fknfw9gxi505amomyyy78665950 FOREIGN KEY (application_group_role_id) REFERENCES security.group_role(id);


--
-- Name: join_catalogue_user_to_user_group fkr4d5x0mewom4ibi8h9qy61ycc; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT fkr4d5x0mewom4ibi8h9qy61ycc FOREIGN KEY (catalogue_user_id) REFERENCES security.catalogue_user(id);


--
-- Name: catalogue_user fkrvd4rw9ujjx4ca9b4dkps3jyt; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapperuser
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT fkrvd4rw9ujjx4ca9b4dkps3jyt FOREIGN KEY (profile_picture_id) REFERENCES core.image_file(id);


--
-- Name: join_termrelationshiptype_to_facet fk16s1q7crb8ipqjg55yc7mmjqm; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk16s1q7crb8ipqjg55yc7mmjqm FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: code_set fk2jwton4ry4smlk76tax1n1j5p; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fk2jwton4ry4smlk76tax1n1j5p FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_term_to_facet fk30th9e8a75qjf08804ttebhsm; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk30th9e8a75qjf08804ttebhsm FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationship_to_facet fk334wl2e2hfjm3641dvx9kbvrr; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk334wl2e2hfjm3641dvx9kbvrr FOREIGN KEY (termrelationship_id) REFERENCES terminology.term_relationship(id);


--
-- Name: join_termrelationshiptype_to_facet fk3ampvxuqr5vc4wnpha04k33in; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk3ampvxuqr5vc4wnpha04k33in FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationshiptype_to_facet fk4p7n1lms874i479o632m3u0bc; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk4p7n1lms874i479o632m3u0bc FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_termrelationship_to_facet fk5nnjqhchac10vbq4dnturf43d; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk5nnjqhchac10vbq4dnturf43d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fk5w07m1k4c62vcduljr349h48j; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk5w07m1k4c62vcduljr349h48j FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_codeset_to_facet fk6cgrkxpermch26tfb07629so4; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fk6cgrkxpermch26tfb07629so4 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fk6kxdv6f6gqa7xkm2bcywsohxy; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk6kxdv6f6gqa7xkm2bcywsohxy FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: terminology fk7dlm65qgt6m8ptacxycqyhl4m; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fk7dlm65qgt6m8ptacxycqyhl4m FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_term_to_facet fk7jn78931gti2jluti9tm592p0; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk7jn78931gti2jluti9tm592p0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_termrelationship_to_facet fk7mj3h26tgnbprkogynq8ws1mx; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk7mj3h26tgnbprkogynq8ws1mx FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_codeset_to_facet fk7t7ilhhckw9qf6xrn1ubfm7d5; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fk7t7ilhhckw9qf6xrn1ubfm7d5 FOREIGN KEY (codeset_id) REFERENCES terminology.code_set(id);


--
-- Name: terminology fk8kiyjbnrjas88qosgt78fdue5; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fk8kiyjbnrjas88qosgt78fdue5 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_terminology_to_facet fk8rh0jwsnqbg5wj37sabpxt808; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fk8rh0jwsnqbg5wj37sabpxt808 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_term_to_facet fk9bpl4j09xy1seyx3iaaueyapu; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk9bpl4j09xy1seyx3iaaueyapu FOREIGN KEY (term_id) REFERENCES terminology.term(id);


--
-- Name: join_termrelationship_to_facet fk9jq2jv72rf5xm5qvhw2808477; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk9jq2jv72rf5xm5qvhw2808477 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: term_relationship fka5wounncpjf0fcv4fpd12j10g; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fka5wounncpjf0fcv4fpd12j10g FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_term_to_facet fkahmuw6nlc4rr8afxo7jw47wdf; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkahmuw6nlc4rr8afxo7jw47wdf FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: term fkcdm4c5ljr1inp380r0bsce94s; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT fkcdm4c5ljr1inp380r0bsce94s FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_codeset_to_facet fkcodeset_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkcodeset_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkcu5iih9ugs9y5guu5mqwdymae; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkcu5iih9ugs9y5guu5mqwdymae FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: term_relationship fkd55uv21yk0qoax6ofaxbg5x9w; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fkd55uv21yk0qoax6ofaxbg5x9w FOREIGN KEY (target_term_id) REFERENCES terminology.term(id);


--
-- Name: join_codeset_to_facet fkd6o1dmjdok9j9f4kk9kry3nlo; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkd6o1dmjdok9j9f4kk9kry3nlo FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_codeset_to_facet fkf251q9vbfhi6t007drkr0ot56; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkf251q9vbfhi6t007drkr0ot56 FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_codeset_to_facet fkf977e6gh0go5gsb1mdypxq5qm; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkf977e6gh0go5gsb1mdypxq5qm FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: code_set fkfxs2u8sgiov5x5jf40oy3q2y3; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fkfxs2u8sgiov5x5jf40oy3q2y3 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_codeset_to_term fkgova93e87cae5ibqn41b9i81q; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_term
    ADD CONSTRAINT fkgova93e87cae5ibqn41b9i81q FOREIGN KEY (codeset_id) REFERENCES terminology.code_set(id);


--
-- Name: join_termrelationship_to_facet fkgx7mfxmfac6cjqhwfy8e0pema; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fkgx7mfxmfac6cjqhwfy8e0pema FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: terminology fkh0m1mr4fvlw79xuod2uffrvhx; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fkh0m1mr4fvlw79xuod2uffrvhx FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_terminology_to_facet fki6m0bt3anil9c8xa1vkro2sex; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fki6m0bt3anil9c8xa1vkro2sex FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fkimkg4xk0vgadayww633utts6m; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fkimkg4xk0vgadayww633utts6m FOREIGN KEY (termrelationshiptype_id) REFERENCES terminology.term_relationship_type(id);


--
-- Name: join_codeset_to_facet fkis38oricalv28ssx3swcyfqe0; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkis38oricalv28ssx3swcyfqe0 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationship_to_facet fkkejqseo866piupm5aos0tcewt; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fkkejqseo866piupm5aos0tcewt FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: term_relationship_type fkksj1p00n2s6upo53rj0g2rcln; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT fkksj1p00n2s6upo53rj0g2rcln FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_terminology_to_facet fkmutj2dw99jmqoiyqs7elxax0b; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkmutj2dw99jmqoiyqs7elxax0b FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: term_relationship fknaqfdwx75pqsv1x4yk4nopa8s; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fknaqfdwx75pqsv1x4yk4nopa8s FOREIGN KEY (source_term_id) REFERENCES terminology.term(id);


--
-- Name: join_codeset_to_facet fkopyxyabfcixr8q5p4tdfiatw; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkopyxyabfcixr8q5p4tdfiatw FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: code_set fkp5k3i717iool706wniwjjvwv3; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fkp5k3i717iool706wniwjjvwv3 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: term_relationship fkpjx0bwxtjt6qewxak7fpgr0pk; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fkpjx0bwxtjt6qewxak7fpgr0pk FOREIGN KEY (relationship_type_id) REFERENCES terminology.term_relationship_type(id);


--
-- Name: term fkpry3m6mjob704x9e0w56auich; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT fkpry3m6mjob704x9e0w56auich FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_term_to_facet fkpvf7f5wddn60lwuucualmnfcu; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkpvf7f5wddn60lwuucualmnfcu FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: term_relationship_type fkqlbqof0u5k91mxq16h2f1p2p8; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT fkqlbqof0u5k91mxq16h2f1p2p8 FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_codeset_to_term fkrce6i901t3rmqwa7oh215fc99; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_codeset_to_term
    ADD CONSTRAINT fkrce6i901t3rmqwa7oh215fc99 FOREIGN KEY (term_id) REFERENCES terminology.term(id);


--
-- Name: join_term_to_facet fks9timcfrvfej60b2b0pinlxs0; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fks9timcfrvfej60b2b0pinlxs0 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_terminology_to_facet fksk9svegop687oy8527bni5mxl; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fksk9svegop687oy8527bni5mxl FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_terminology_to_facet fkt5xk7gkhiyj0y1snpsqhgwnhk; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkt5xk7gkhiyj0y1snpsqhgwnhk FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_term_to_facet fkterm_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkterm_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkterminology_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkterminology_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_termrelationship_to_facet fktermrelationship_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fktermrelationship_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_termrelationshiptype_to_facet fktermrelationshiptype_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fktermrelationshiptype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkti72ejs5r77aweqn2voaukggw; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapperuser
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkti72ejs5r77aweqn2voaukggw FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- PostgreSQL database dump complete
--

