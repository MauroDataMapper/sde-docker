--
-- PostgreSQL database dump
--

\c sdecore

-- Dumped from database version 14.11 (Postgres.app)
-- Dumped by pg_dump version 14.11 (Postgres.app)

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
-- Name: management; Type: SCHEMA; Schema: -; Owner: sdecore
--

CREATE SCHEMA management;


ALTER SCHEMA management OWNER TO sdecore;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA management;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_users; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.admin_users (
    id uuid NOT NULL,
    type text DEFAULT 'Admin'::text NOT NULL,
    CONSTRAINT admin_users_type_check CHECK ((type = 'Admin'::text))
);


ALTER TABLE management.admin_users OWNER TO sdecore;

--
-- Name: archive_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.archive_requests (
    id uuid NOT NULL,
    project_id uuid NOT NULL,
    research_user_approval_id uuid,
    type text DEFAULT 'Archive'::text NOT NULL,
    CONSTRAINT archive_requests_type_check CHECK ((type = 'Archive'::text))
);


ALTER TABLE management.archive_requests OWNER TO sdecore;

--
-- Name: audit; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.audit (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    audit_type text NOT NULL,
    table_name text NOT NULL,
    details text,
    CONSTRAINT audit_audit_type_check CHECK ((audit_type = ANY (ARRAY['create'::text, 'update'::text, 'read'::text, 'delete'::text])))
);


ALTER TABLE management.audit OWNER TO sdecore;

--
-- Name: COLUMN audit.details; Type: COMMENT; Schema: management; Owner: sdecore
--

COMMENT ON COLUMN management.audit.details IS 'Additional information, for type="create" the values that being added, for "update" the changed values, for "delete" is NULL - the details, when stored, are in JSON format';


--
-- Name: data_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.data_requests (
    id uuid NOT NULL,
    project_id uuid NOT NULL,
    research_user_approval_id uuid,
    type text DEFAULT 'Data'::text NOT NULL,
    mauro_data_specification_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    CONSTRAINT data_requests_type_check CHECK ((type = 'Data'::text))
);


ALTER TABLE management.data_requests OWNER TO sdecore;

--
-- Name: department_members; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.department_members (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_user_id uuid NOT NULL,
    department_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role text NOT NULL,
    end_date timestamp without time zone NOT NULL,
    CONSTRAINT organisation_members_role_check CHECK ((role = ANY (ARRAY['MEMBER'::text, 'APPROVER'::text])))
);


ALTER TABLE management.department_members OWNER TO sdecore;

--
-- Name: department_members_evidence; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.department_members_evidence (
    department_members_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE management.department_members_evidence OWNER TO sdecore;

--
-- Name: department_members_history; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.department_members_history (
    id uuid NOT NULL,
    created_by_user_id uuid NOT NULL,
    department_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role text NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    CONSTRAINT organisation_members_history_role_check CHECK ((role = ANY (ARRAY['MEMBER'::text, 'APPROVER'::text])))
);


ALTER TABLE management.department_members_history OWNER TO sdecore;

--
-- Name: department_members_history_evidence; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.department_members_history_evidence (
    department_members_history_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE management.department_members_history_evidence OWNER TO sdecore;

--
-- Name: departmental_approval_requirements; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.departmental_approval_requirements (
    id uuid NOT NULL,
    request_id uuid NOT NULL,
    department_id uuid NOT NULL,
    research_user_approval_id uuid
);


ALTER TABLE management.departmental_approval_requirements OWNER TO sdecore;

--
-- Name: departments; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.departments (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_user_id uuid NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    mauro_core_group text,
    is_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE management.departments OWNER TO sdecore;

--
-- Name: export_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.export_requests (
    id uuid NOT NULL,
    project_id uuid NOT NULL,
    research_user_approval_id uuid,
    type text DEFAULT 'Export'::text NOT NULL,
    CONSTRAINT export_requests_type_check CHECK ((type = 'Export'::text))
);


ALTER TABLE management.export_requests OWNER TO sdecore;

--
-- Name: files; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.files (
    id uuid NOT NULL,
    upload_date timestamp without time zone NOT NULL,
    upload_by_user_id uuid NOT NULL,
    location text NOT NULL,
    name text NOT NULL,
    content_type text
);


ALTER TABLE management.files OWNER TO sdecore;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.flyway_schema_history (
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


ALTER TABLE management.flyway_schema_history OWNER TO sdecore;

--
-- Name: help_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.help_requests (
    id uuid NOT NULL,
    type text DEFAULT 'Help'::text NOT NULL,
    CONSTRAINT help_requests_type_check CHECK ((type = 'Help'::text))
);


ALTER TABLE management.help_requests OWNER TO sdecore;

--
-- Name: import_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.import_requests (
    id uuid NOT NULL,
    project_id uuid NOT NULL,
    research_user_approval_id uuid,
    type text DEFAULT 'Import'::text NOT NULL,
    CONSTRAINT import_requests_type_check CHECK ((type = 'Import'::text))
);


ALTER TABLE management.import_requests OWNER TO sdecore;

--
-- Name: information_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.information_requests (
    id uuid NOT NULL,
    type text DEFAULT 'Info'::text NOT NULL,
    department_id uuid NOT NULL,
    CONSTRAINT information_requests_type_check CHECK ((type = 'Info'::text))
);


ALTER TABLE management.information_requests OWNER TO sdecore;

--
-- Name: new_project_departments; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.new_project_departments (
    id uuid NOT NULL,
    request_id uuid NOT NULL,
    email text NOT NULL,
    dont_match boolean DEFAULT false NOT NULL,
    department_id uuid
);


ALTER TABLE management.new_project_departments OWNER TO sdecore;

--
-- Name: new_project_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.new_project_requests (
    id uuid NOT NULL,
    type text DEFAULT 'New Project'::text NOT NULL,
    project_name text NOT NULL,
    description_of_scope text NOT NULL,
    budget numeric(19,4) NOT NULL,
    end_date timestamp without time zone NOT NULL,
    department_id uuid NOT NULL,
    resulting_project_id uuid,
    CONSTRAINT new_project_requests_type_check CHECK ((type = 'New Project'::text))
);


ALTER TABLE management.new_project_requests OWNER TO sdecore;

--
-- Name: organisation_departments; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.organisation_departments (
    organisation_id uuid NOT NULL,
    department_id uuid NOT NULL
);


ALTER TABLE management.organisation_departments OWNER TO sdecore;

--
-- Name: organisation_members; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.organisation_members (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_user_id uuid NOT NULL,
    role text NOT NULL,
    research_user_id uuid NOT NULL,
    organisation_id uuid NOT NULL,
    end_date timestamp without time zone
);


ALTER TABLE management.organisation_members OWNER TO sdecore;

--
-- Name: organisations; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.organisations (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_user_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    is_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE management.organisations OWNER TO sdecore;

--
-- Name: project_change_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.project_change_requests (
    id uuid NOT NULL,
    type text DEFAULT 'Project Change'::text NOT NULL,
    new_description_of_scope text NOT NULL,
    new_budget numeric(19,4) NOT NULL,
    new_end_date timestamp without time zone NOT NULL,
    project_id uuid NOT NULL,
    CONSTRAINT project_change_requests_type_check CHECK ((type = 'Project Change'::text))
);


ALTER TABLE management.project_change_requests OWNER TO sdecore;

--
-- Name: project_department_change_request; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.project_department_change_request (
    id uuid NOT NULL,
    request_id uuid NOT NULL,
    department_id uuid NOT NULL,
    action text NOT NULL,
    CONSTRAINT project_organisation_change_request_action_check CHECK ((action = ANY (ARRAY['ADD'::text, 'REMOVE'::text])))
);


ALTER TABLE management.project_department_change_request OWNER TO sdecore;

--
-- Name: project_departments; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.project_departments (
    project_id uuid NOT NULL,
    department_id uuid NOT NULL
);


ALTER TABLE management.project_departments OWNER TO sdecore;

--
-- Name: project_members; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.project_members (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_user_id uuid NOT NULL,
    project_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role text NOT NULL,
    end_date timestamp without time zone NOT NULL,
    CONSTRAINT project_members_role_check CHECK ((role = ANY (ARRAY['OBSERVER'::text, 'RESEARCHER'::text, 'MANAGER'::text])))
);


ALTER TABLE management.project_members OWNER TO sdecore;

--
-- Name: project_members_evidence; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.project_members_evidence (
    project_members_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE management.project_members_evidence OWNER TO sdecore;

--
-- Name: project_members_history; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.project_members_history (
    id uuid NOT NULL,
    created_by_user_id uuid NOT NULL,
    project_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role text NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    CONSTRAINT project_members_history_role_check CHECK ((role = ANY (ARRAY['OBSERVER'::text, 'RESEARCHER'::text, 'MANAGER'::text])))
);


ALTER TABLE management.project_members_history OWNER TO sdecore;

--
-- Name: project_members_history_evidence; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.project_members_history_evidence (
    project_members_history_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE management.project_members_history_evidence OWNER TO sdecore;

--
-- Name: projects; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.projects (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_user_id uuid NOT NULL,
    name text NOT NULL,
    description_of_scope text NOT NULL,
    virtual_machine_ids text,
    budget numeric(19,4) NOT NULL,
    sponsoring_department_id uuid NOT NULL,
    end_date timestamp without time zone NOT NULL,
    is_deleted boolean NOT NULL
);


ALTER TABLE management.projects OWNER TO sdecore;

--
-- Name: request_attachments; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.request_attachments (
    id uuid NOT NULL,
    file_id uuid NOT NULL,
    request_id uuid NOT NULL,
    request_update_id uuid,
    attachment_type text NOT NULL
);


ALTER TABLE management.request_attachments OWNER TO sdecore;

--
-- Name: request_updates; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.request_updates (
    id uuid NOT NULL,
    request_id uuid NOT NULL,
    updated_by_user_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    comment text,
    status_before text,
    status_after text,
    assigned_user_id_before uuid,
    assigned_user_id_after uuid,
    sequence_tiebreak integer DEFAULT 0 NOT NULL,
    CONSTRAINT request_updates_status_after_check CHECK ((status_after = ANY (ARRAY['DRAFT'::text, 'AWAITING_APPROVAL'::text, 'AWAITING_PICKUP'::text, 'ASSIGNED'::text, 'IN_REVIEW_FEASIBILITY'::text, 'IN_REVIEW_PROJECT_SCOPE'::text, 'IN_REVIEW_GOVERNANCE'::text, 'APPROVED_PENDING'::text, 'APPROVED_IN_PROGRESS'::text, 'COMPLETE_AWAITING_ACKNOWLEDGEMENT'::text, 'RETURNED'::text, 'CLOSED'::text]))),
    CONSTRAINT request_updates_status_before_check CHECK ((status_before = ANY (ARRAY['DRAFT'::text, 'AWAITING_APPROVAL'::text, 'AWAITING_PICKUP'::text, 'ASSIGNED'::text, 'IN_REVIEW_FEASIBILITY'::text, 'IN_REVIEW_PROJECT_SCOPE'::text, 'IN_REVIEW_GOVERNANCE'::text, 'APPROVED_PENDING'::text, 'APPROVED_IN_PROGRESS'::text, 'COMPLETE_AWAITING_ACKNOWLEDGEMENT'::text, 'RETURNED'::text, 'CLOSED'::text])))
);


ALTER TABLE management.request_updates OWNER TO sdecore;

--
-- Name: requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.requests (
    id uuid NOT NULL,
    type text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by_user_id uuid NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    date_submitted timestamp without time zone,
    status text NOT NULL,
    assigned_to_user_id uuid,
    next_update_eta timestamp without time zone,
    CONSTRAINT requests_status_check CHECK ((status = ANY (ARRAY['DRAFT'::text, 'AWAITING_APPROVAL'::text, 'AWAITING_PICKUP'::text, 'ASSIGNED'::text, 'IN_REVIEW_FEASIBILITY'::text, 'IN_REVIEW_PROJECT_SCOPE'::text, 'IN_REVIEW_GOVERNANCE'::text, 'APPROVED_PENDING'::text, 'APPROVED_IN_PROGRESS'::text, 'COMPLETE_AWAITING_ACKNOWLEDGEMENT'::text, 'RETURNED'::text, 'CLOSED'::text]))),
    CONSTRAINT requests_type_check CHECK ((type = ANY (ARRAY['Help'::text, 'Info'::text, 'New Project'::text, 'Project Change'::text, 'Resource'::text, 'Data'::text, 'Import'::text, 'Export'::text, 'Archive'::text])))
);


ALTER TABLE management.requests OWNER TO sdecore;

--
-- Name: research_user_approvals; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.research_user_approvals (
    id uuid NOT NULL,
    deciding_user_id uuid NOT NULL,
    decision text NOT NULL,
    decision_date timestamp without time zone NOT NULL,
    CONSTRAINT research_user_approvals_decision_check CHECK ((decision = ANY (ARRAY['APPROVED'::text, 'REJECTED'::text])))
);


ALTER TABLE management.research_user_approvals OWNER TO sdecore;

--
-- Name: research_users; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.research_users (
    id uuid NOT NULL,
    type text DEFAULT 'Research'::text NOT NULL,
    preferred_name text NOT NULL,
    preferred_contact_details text,
    short_bio text,
    vetting_process_details text,
    organisation_member_id uuid,
    CONSTRAINT research_users_type_check CHECK ((type = 'Research'::text))
);


ALTER TABLE management.research_users OWNER TO sdecore;

--
-- Name: resource_requests; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.resource_requests (
    id uuid NOT NULL,
    project_id uuid NOT NULL,
    research_user_approval_id uuid,
    type text DEFAULT 'Resource'::text NOT NULL,
    CONSTRAINT resource_requests_type_check CHECK ((type = 'Resource'::text))
);


ALTER TABLE management.resource_requests OWNER TO sdecore;

--
-- Name: users; Type: TABLE; Schema: management; Owner: sdecore
--

CREATE TABLE management.users (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    type text NOT NULL,
    email text NOT NULL,
    mauro_core_user text,
    is_deleted boolean DEFAULT false NOT NULL,
    oidc_issuing_authority text,
    oidc_subject text,
    CONSTRAINT users_type_check CHECK ((type = ANY (ARRAY['Admin'::text, 'Research'::text])))
);


ALTER TABLE management.users OWNER TO sdecore;

--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.admin_users (id, type) FROM stdin;
\.


--
-- Data for Name: archive_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.archive_requests (id, project_id, research_user_approval_id, type) FROM stdin;
\.


--
-- Data for Name: audit; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.audit (id, user_id, created_at, audit_type, table_name, details) FROM stdin;
\.


--
-- Data for Name: data_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.data_requests (id, project_id, research_user_approval_id, type, mauro_data_specification_id) FROM stdin;
\.


--
-- Data for Name: department_members; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.department_members (id, created_at, created_by_user_id, department_id, user_id, role, end_date) FROM stdin;
\.


--
-- Data for Name: department_members_evidence; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.department_members_evidence (department_members_id, file_id) FROM stdin;
\.


--
-- Data for Name: department_members_history; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.department_members_history (id, created_by_user_id, department_id, user_id, role, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: department_members_history_evidence; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.department_members_history_evidence (department_members_history_id, file_id) FROM stdin;
\.


--
-- Data for Name: departmental_approval_requirements; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.departmental_approval_requirements (id, request_id, department_id, research_user_approval_id) FROM stdin;
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.departments (id, created_at, created_by_user_id, name, description, mauro_core_group, is_deleted) FROM stdin;
\.


--
-- Data for Name: export_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.export_requests (id, project_id, research_user_approval_id, type) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.files (id, upload_date, upload_by_user_id, location, name, content_type) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
0	\N	<< Flyway Schema Creation >>	SCHEMA	"management"	\N	sdecore	2024-10-08 09:17:31.219814	0	t
1	1.0.0	Setup initial tables	SQL	V1.0.0__Setup_initial_tables.sql	-1331888571	sdecore	2024-10-08 09:17:31.342914	215	t
2	1.0.1	Setup organisation tables	SQL	V1.0.1__Setup_organisation_tables.sql	-1075815812	sdecore	2024-10-08 09:17:31.577988	119	t
3	1.0.2	Setup project tables	SQL	V1.0.2__Setup_project_tables.sql	11991774	sdecore	2024-10-08 09:17:31.705231	90	t
4	1.0.3	Setup request periphery tables	SQL	V1.0.3__Setup_request_periphery_tables.sql	-1228589416	sdecore	2024-10-08 09:17:31.812425	106	t
5	1.0.4	Setup approval tables	SQL	V1.0.4__Setup_approval_tables.sql	-580354829	sdecore	2024-10-08 09:17:31.926835	34	t
6	1.0.5	Create request tables	SQL	V1.0.5__Create_request_tables.sql	1700411640	sdecore	2024-10-08 09:17:31.970826	90	t
7	1.0.6	Setup request tables projects orgs	SQL	V1.0.6__Setup_request_tables_projects_orgs.sql	423421452	sdecore	2024-10-08 09:17:32.070622	70	t
8	1.0.7	Setup evidence tables	SQL	V1.0.7__Setup_evidence_tables.sql	-1311676340	sdecore	2024-10-08 09:17:32.149222	46	t
9	1.0.8	New project organisations	SQL	V1.0.8__New_project_organisations.sql	1960001790	sdecore	2024-10-08 09:17:32.203843	14	t
10	1.0.9	Add File name and type	SQL	V1.0.9__Add_File_name_and_type.sql	283572417	sdecore	2024-10-08 09:17:32.225252	20	t
11	1.0.10	Add project id to new project request	SQL	V1.0.10__Add_project_id_to_new_project_request.sql	1616499231	sdecore	2024-10-08 09:17:32.250483	21	t
12	1.0.11	Index resulting project id	SQL	V1.0.11__Index_resulting_project_id.sql	1756396518	sdecore	2024-10-08 09:17:32.276092	7	t
13	1.0.12	New project request additional organisation matching	SQL	V1.0.12__New_project_request_additional_organisation_matching.sql	-1465946882	sdecore	2024-10-08 09:17:32.287866	45	t
14	1.0.13	Drop request data specifications table	SQL	V1.0.13__Drop_request_data_specifications_table.sql	-1161769670	sdecore	2024-10-08 09:17:32.346824	30	t
15	1.0.14	Add attachment type field	SQL	V1.0.14__Add_attachment_type_field.sql	947738166	sdecore	2024-10-08 09:17:32.387204	22	t
16	1.0.15	Rename organisation to department	SQL	V1.0.15__Rename_organisation_to_department.sql	1226917746	sdecore	2024-10-08 09:17:32.413131	105	t
17	1.0.16	Add audit table	SQL	V1.0.16__Add_audit_table.sql	727529319	sdecore	2024-10-08 09:17:32.526951	22	t
18	1.0.17	Create anonymous research user	SQL	V1.0.17__Create_anonymous_research_user.sql	1127263099	sdecore	2024-10-08 09:17:32.554556	141	t
19	1.0.18	Introduce tiebreak for request updates	SQL	V1.0.18__Introduce_tiebreak_for_request_updates.sql	1677409516	sdecore	2024-10-08 09:17:32.702556	8	t
20	1.0.19	Create organisation again	SQL	V1.0.19__Create_organisation_again.sql	-1649920931	sdecore	2024-10-08 09:17:32.718144	54	t
\.


--
-- Data for Name: help_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.help_requests (id, type) FROM stdin;
\.


--
-- Data for Name: import_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.import_requests (id, project_id, research_user_approval_id, type) FROM stdin;
\.


--
-- Data for Name: information_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.information_requests (id, type, department_id) FROM stdin;
\.


--
-- Data for Name: new_project_departments; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.new_project_departments (id, request_id, email, dont_match, department_id) FROM stdin;
\.


--
-- Data for Name: new_project_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.new_project_requests (id, type, project_name, description_of_scope, budget, end_date, department_id, resulting_project_id) FROM stdin;
\.


--
-- Data for Name: organisation_departments; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.organisation_departments (organisation_id, department_id) FROM stdin;
\.


--
-- Data for Name: organisation_members; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.organisation_members (id, created_at, created_by_user_id, role, research_user_id, organisation_id, end_date) FROM stdin;
\.


--
-- Data for Name: organisations; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.organisations (id, created_at, created_by_user_id, name, description, is_deleted) FROM stdin;
\.


--
-- Data for Name: project_change_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.project_change_requests (id, type, new_description_of_scope, new_budget, new_end_date, project_id) FROM stdin;
\.


--
-- Data for Name: project_department_change_request; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.project_department_change_request (id, request_id, department_id, action) FROM stdin;
\.


--
-- Data for Name: project_departments; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.project_departments (project_id, department_id) FROM stdin;
\.


--
-- Data for Name: project_members; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.project_members (id, created_at, created_by_user_id, project_id, user_id, role, end_date) FROM stdin;
\.


--
-- Data for Name: project_members_evidence; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.project_members_evidence (project_members_id, file_id) FROM stdin;
\.


--
-- Data for Name: project_members_history; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.project_members_history (id, created_by_user_id, project_id, user_id, role, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: project_members_history_evidence; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.project_members_history_evidence (project_members_history_id, file_id) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.projects (id, created_at, created_by_user_id, name, description_of_scope, virtual_machine_ids, budget, sponsoring_department_id, end_date, is_deleted) FROM stdin;
\.


--
-- Data for Name: request_attachments; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.request_attachments (id, file_id, request_id, request_update_id, attachment_type) FROM stdin;
\.


--
-- Data for Name: request_updates; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.request_updates (id, request_id, updated_by_user_id, created_at, comment, status_before, status_after, assigned_user_id_before, assigned_user_id_after, sequence_tiebreak) FROM stdin;
\.


--
-- Data for Name: requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.requests (id, type, created_at, created_by_user_id, title, content, date_submitted, status, assigned_to_user_id, next_update_eta) FROM stdin;
\.


--
-- Data for Name: research_user_approvals; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.research_user_approvals (id, deciding_user_id, decision, decision_date) FROM stdin;
\.


--
-- Data for Name: research_users; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.research_users (id, type, preferred_name, preferred_contact_details, short_bio, vetting_process_details, organisation_member_id) FROM stdin;
20bc6a13-7373-4b5c-b72f-34b44cab8b90	Research	Anonymous User	\N	\N	\N	\N
\.


--
-- Data for Name: resource_requests; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.resource_requests (id, project_id, research_user_approval_id, type) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: management; Owner: sdecore
--

COPY management.users (id, created_at, type, email, mauro_core_user, is_deleted, oidc_issuing_authority, oidc_subject) FROM stdin;
20bc6a13-7373-4b5c-b72f-34b44cab8b90	2024-10-08 09:17:32.557326	Research	anonymous.researcher@anonymous.com	\N	f	\N	\N
\.


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: archive_requests archive_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.archive_requests
    ADD CONSTRAINT archive_requests_pkey PRIMARY KEY (id);


--
-- Name: audit audit_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.audit
    ADD CONSTRAINT audit_pkey PRIMARY KEY (id);


--
-- Name: data_requests data_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.data_requests
    ADD CONSTRAINT data_requests_pkey PRIMARY KEY (id);


--
-- Name: export_requests export_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.export_requests
    ADD CONSTRAINT export_requests_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: help_requests help_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.help_requests
    ADD CONSTRAINT help_requests_pkey PRIMARY KEY (id);


--
-- Name: import_requests import_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.import_requests
    ADD CONSTRAINT import_requests_pkey PRIMARY KEY (id);


--
-- Name: information_requests information_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.information_requests
    ADD CONSTRAINT information_requests_pkey PRIMARY KEY (id);


--
-- Name: new_project_departments new_project_organisations_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.new_project_departments
    ADD CONSTRAINT new_project_organisations_pkey PRIMARY KEY (id);


--
-- Name: new_project_departments new_project_organisations_request_id_email_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.new_project_departments
    ADD CONSTRAINT new_project_organisations_request_id_email_key UNIQUE (request_id, email);


--
-- Name: new_project_requests new_project_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.new_project_requests
    ADD CONSTRAINT new_project_requests_pkey PRIMARY KEY (id);


--
-- Name: organisation_departments organisation_departments_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_departments
    ADD CONSTRAINT organisation_departments_pkey PRIMARY KEY (organisation_id, department_id);


--
-- Name: department_members_evidence organisation_members_evidence_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_evidence
    ADD CONSTRAINT organisation_members_evidence_pkey PRIMARY KEY (department_members_id, file_id);


--
-- Name: department_members_history_evidence organisation_members_history_evidence_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_history_evidence
    ADD CONSTRAINT organisation_members_history_evidence_pkey PRIMARY KEY (department_members_history_id, file_id);


--
-- Name: department_members_history organisation_members_history_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_history
    ADD CONSTRAINT organisation_members_history_pkey PRIMARY KEY (id);


--
-- Name: department_members organisation_members_organisation_id_user_id_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members
    ADD CONSTRAINT organisation_members_organisation_id_user_id_key UNIQUE (department_id, user_id);


--
-- Name: department_members organisation_members_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members
    ADD CONSTRAINT organisation_members_pkey PRIMARY KEY (id);


--
-- Name: organisation_members organisation_members_pkey1; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_members
    ADD CONSTRAINT organisation_members_pkey1 PRIMARY KEY (id);


--
-- Name: organisation_members organisation_members_research_user_id_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_members
    ADD CONSTRAINT organisation_members_research_user_id_key UNIQUE (research_user_id);


--
-- Name: departmental_approval_requirements organisational_approval_requirements_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.departmental_approval_requirements
    ADD CONSTRAINT organisational_approval_requirements_pkey PRIMARY KEY (id);


--
-- Name: organisations organisations_name_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisations
    ADD CONSTRAINT organisations_name_key UNIQUE (name);


--
-- Name: departments organisations_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.departments
    ADD CONSTRAINT organisations_pkey PRIMARY KEY (id);


--
-- Name: organisations organisations_pkey1; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisations
    ADD CONSTRAINT organisations_pkey1 PRIMARY KEY (id);


--
-- Name: project_change_requests project_change_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_change_requests
    ADD CONSTRAINT project_change_requests_pkey PRIMARY KEY (id);


--
-- Name: project_members_evidence project_members_evidence_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_evidence
    ADD CONSTRAINT project_members_evidence_pkey PRIMARY KEY (project_members_id, file_id);


--
-- Name: project_members_history_evidence project_members_history_evidence_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_history_evidence
    ADD CONSTRAINT project_members_history_evidence_pkey PRIMARY KEY (project_members_history_id, file_id);


--
-- Name: project_members_history project_members_history_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_history
    ADD CONSTRAINT project_members_history_pkey PRIMARY KEY (id);


--
-- Name: project_members project_members_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members
    ADD CONSTRAINT project_members_pkey PRIMARY KEY (id);


--
-- Name: project_members project_members_project_id_user_id_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members
    ADD CONSTRAINT project_members_project_id_user_id_key UNIQUE (project_id, user_id);


--
-- Name: project_department_change_request project_organisation_change_request_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_department_change_request
    ADD CONSTRAINT project_organisation_change_request_pkey PRIMARY KEY (id);


--
-- Name: project_departments project_organisations_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_departments
    ADD CONSTRAINT project_organisations_pkey PRIMARY KEY (project_id, department_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: request_attachments request_attachments_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_attachments
    ADD CONSTRAINT request_attachments_pkey PRIMARY KEY (id);


--
-- Name: request_updates request_updates_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_updates
    ADD CONSTRAINT request_updates_pkey PRIMARY KEY (id);


--
-- Name: requests requests_id_type_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.requests
    ADD CONSTRAINT requests_id_type_key UNIQUE (id, type);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: research_user_approvals research_user_approvals_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.research_user_approvals
    ADD CONSTRAINT research_user_approvals_pkey PRIMARY KEY (id);


--
-- Name: research_users research_users_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.research_users
    ADD CONSTRAINT research_users_pkey PRIMARY KEY (id);


--
-- Name: resource_requests resource_requests_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.resource_requests
    ADD CONSTRAINT resource_requests_pkey PRIMARY KEY (id);


--
-- Name: request_updates unique_request_id; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_updates
    ADD CONSTRAINT unique_request_id UNIQUE (id, request_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_id_type_key; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.users
    ADD CONSTRAINT users_id_type_key UNIQUE (id, type);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: management; Owner: sdecore
--

CREATE INDEX flyway_schema_history_s_idx ON management.flyway_schema_history USING btree (success);


--
-- Name: idx_org_name_deleted_true; Type: INDEX; Schema: management; Owner: sdecore
--

CREATE UNIQUE INDEX idx_org_name_deleted_true ON management.departments USING btree (name) WHERE (is_deleted = false);


--
-- Name: new_project_requests_resulting_project_id; Type: INDEX; Schema: management; Owner: sdecore
--

CREATE UNIQUE INDEX new_project_requests_resulting_project_id ON management.new_project_requests USING btree (resulting_project_id);


--
-- Name: unique_mauro_data_spec_id_except_zero; Type: INDEX; Schema: management; Owner: sdecore
--

CREATE UNIQUE INDEX unique_mauro_data_spec_id_except_zero ON management.data_requests USING btree (mauro_data_specification_id) WHERE (mauro_data_specification_id <> '00000000-0000-0000-0000-000000000000'::uuid);


--
-- Name: departments fk_admin_users_from_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.departments
    ADD CONSTRAINT fk_admin_users_from_departments FOREIGN KEY (created_by_user_id) REFERENCES management.admin_users(id);


--
-- Name: projects fk_admin_users_from_projects; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.projects
    ADD CONSTRAINT fk_admin_users_from_projects FOREIGN KEY (created_by_user_id) REFERENCES management.admin_users(id);


--
-- Name: requests fk_admin_users_from_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.requests
    ADD CONSTRAINT fk_admin_users_from_requests FOREIGN KEY (assigned_to_user_id) REFERENCES management.admin_users(id);


--
-- Name: request_updates fk_assigned_user_after_from_admin_users; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_updates
    ADD CONSTRAINT fk_assigned_user_after_from_admin_users FOREIGN KEY (assigned_user_id_after) REFERENCES management.admin_users(id);


--
-- Name: request_updates fk_assigned_user_before_from_admin_users; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_updates
    ADD CONSTRAINT fk_assigned_user_before_from_admin_users FOREIGN KEY (assigned_user_id_before) REFERENCES management.admin_users(id);


--
-- Name: research_user_approvals fk_deciding_user_id_from_users; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.research_user_approvals
    ADD CONSTRAINT fk_deciding_user_id_from_users FOREIGN KEY (deciding_user_id) REFERENCES management.research_users(id);


--
-- Name: departmental_approval_requirements fk_department_id_from_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.departmental_approval_requirements
    ADD CONSTRAINT fk_department_id_from_departments FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: information_requests fk_department_id_from_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.information_requests
    ADD CONSTRAINT fk_department_id_from_departments FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: new_project_requests fk_department_id_from_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.new_project_requests
    ADD CONSTRAINT fk_department_id_from_departments FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: project_department_change_request fk_department_id_from_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_department_change_request
    ADD CONSTRAINT fk_department_id_from_departments FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: department_members_history_evidence fk_department_members_history_id_from_department_members_histor; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_history_evidence
    ADD CONSTRAINT fk_department_members_history_id_from_department_members_histor FOREIGN KEY (department_members_history_id) REFERENCES management.department_members_history(id);


--
-- Name: department_members_evidence fk_department_members_id_from_department_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_evidence
    ADD CONSTRAINT fk_department_members_id_from_department_members FOREIGN KEY (department_members_id) REFERENCES management.department_members(id);


--
-- Name: department_members fk_departments_from_department_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members
    ADD CONSTRAINT fk_departments_from_department_members FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: department_members_history fk_departments_from_department_members_history; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_history
    ADD CONSTRAINT fk_departments_from_department_members_history FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: organisation_departments fk_departments_from_organisation_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_departments
    ADD CONSTRAINT fk_departments_from_organisation_departments FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: project_departments fk_departments_from_project_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_departments
    ADD CONSTRAINT fk_departments_from_project_departments FOREIGN KEY (department_id) REFERENCES management.departments(id);


--
-- Name: projects fk_departments_from_projects; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.projects
    ADD CONSTRAINT fk_departments_from_projects FOREIGN KEY (sponsoring_department_id) REFERENCES management.departments(id);


--
-- Name: request_attachments fk_file_id_from_files; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_attachments
    ADD CONSTRAINT fk_file_id_from_files FOREIGN KEY (file_id) REFERENCES management.files(id);


--
-- Name: department_members_evidence fk_file_id_from_files; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_evidence
    ADD CONSTRAINT fk_file_id_from_files FOREIGN KEY (file_id) REFERENCES management.files(id);


--
-- Name: department_members_history_evidence fk_file_id_from_files; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_history_evidence
    ADD CONSTRAINT fk_file_id_from_files FOREIGN KEY (file_id) REFERENCES management.files(id);


--
-- Name: project_members_evidence fk_file_id_from_files; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_evidence
    ADD CONSTRAINT fk_file_id_from_files FOREIGN KEY (file_id) REFERENCES management.files(id);


--
-- Name: project_members_history_evidence fk_file_id_from_files; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_history_evidence
    ADD CONSTRAINT fk_file_id_from_files FOREIGN KEY (file_id) REFERENCES management.files(id);


--
-- Name: organisation_members fk_organisation_from_organisation_member; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_members
    ADD CONSTRAINT fk_organisation_from_organisation_member FOREIGN KEY (organisation_id) REFERENCES management.organisations(id);


--
-- Name: organisation_departments fk_organisations_from_organisation_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_departments
    ADD CONSTRAINT fk_organisations_from_organisation_departments FOREIGN KEY (organisation_id) REFERENCES management.organisations(id);


--
-- Name: project_change_requests fk_project_id_from_projects; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_change_requests
    ADD CONSTRAINT fk_project_id_from_projects FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: project_members_history_evidence fk_project_members_history_id_from_project_members_history; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_history_evidence
    ADD CONSTRAINT fk_project_members_history_id_from_project_members_history FOREIGN KEY (project_members_history_id) REFERENCES management.project_members_history(id);


--
-- Name: project_members_evidence fk_project_members_id_from_project_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_evidence
    ADD CONSTRAINT fk_project_members_id_from_project_members FOREIGN KEY (project_members_id) REFERENCES management.project_members(id);


--
-- Name: archive_requests fk_projects_from_archive_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.archive_requests
    ADD CONSTRAINT fk_projects_from_archive_requests FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: data_requests fk_projects_from_data_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.data_requests
    ADD CONSTRAINT fk_projects_from_data_requests FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: export_requests fk_projects_from_export_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.export_requests
    ADD CONSTRAINT fk_projects_from_export_requests FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: import_requests fk_projects_from_import_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.import_requests
    ADD CONSTRAINT fk_projects_from_import_requests FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: new_project_requests fk_projects_from_new_project_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.new_project_requests
    ADD CONSTRAINT fk_projects_from_new_project_requests FOREIGN KEY (resulting_project_id) REFERENCES management.projects(id);


--
-- Name: project_departments fk_projects_from_project_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_departments
    ADD CONSTRAINT fk_projects_from_project_departments FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: project_members_history fk_projects_from_project_member_history; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_history
    ADD CONSTRAINT fk_projects_from_project_member_history FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: project_members fk_projects_from_project_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members
    ADD CONSTRAINT fk_projects_from_project_members FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: resource_requests fk_projects_from_resource_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.resource_requests
    ADD CONSTRAINT fk_projects_from_resource_requests FOREIGN KEY (project_id) REFERENCES management.projects(id);


--
-- Name: project_department_change_request fk_request_id_from_project_change_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_department_change_request
    ADD CONSTRAINT fk_request_id_from_project_change_requests FOREIGN KEY (request_id) REFERENCES management.project_change_requests(id);


--
-- Name: request_updates fk_request_id_from_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_updates
    ADD CONSTRAINT fk_request_id_from_requests FOREIGN KEY (request_id) REFERENCES management.requests(id);


--
-- Name: request_attachments fk_request_id_from_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_attachments
    ADD CONSTRAINT fk_request_id_from_requests FOREIGN KEY (request_id) REFERENCES management.requests(id);


--
-- Name: departmental_approval_requirements fk_request_id_from_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.departmental_approval_requirements
    ADD CONSTRAINT fk_request_id_from_requests FOREIGN KEY (request_id) REFERENCES management.requests(id);


--
-- Name: request_attachments fk_request_update_id_from_request_updates; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_attachments
    ADD CONSTRAINT fk_request_update_id_from_request_updates FOREIGN KEY (request_update_id, request_id) REFERENCES management.request_updates(id, request_id);


--
-- Name: archive_requests fk_requests_from_archive_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.archive_requests
    ADD CONSTRAINT fk_requests_from_archive_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: data_requests fk_requests_from_data_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.data_requests
    ADD CONSTRAINT fk_requests_from_data_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: export_requests fk_requests_from_export_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.export_requests
    ADD CONSTRAINT fk_requests_from_export_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: help_requests fk_requests_from_help_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.help_requests
    ADD CONSTRAINT fk_requests_from_help_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: import_requests fk_requests_from_import_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.import_requests
    ADD CONSTRAINT fk_requests_from_import_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: information_requests fk_requests_from_information_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.information_requests
    ADD CONSTRAINT fk_requests_from_information_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: new_project_requests fk_requests_from_information_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.new_project_requests
    ADD CONSTRAINT fk_requests_from_information_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: project_change_requests fk_requests_from_information_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_change_requests
    ADD CONSTRAINT fk_requests_from_information_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: new_project_departments fk_requests_from_new_project_departments; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.new_project_departments
    ADD CONSTRAINT fk_requests_from_new_project_departments FOREIGN KEY (request_id) REFERENCES management.new_project_requests(id);


--
-- Name: resource_requests fk_requests_from_resource_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.resource_requests
    ADD CONSTRAINT fk_requests_from_resource_requests FOREIGN KEY (id, type) REFERENCES management.requests(id, type);


--
-- Name: departmental_approval_requirements fk_research_user_approval_id_from_research_user_approvals; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.departmental_approval_requirements
    ADD CONSTRAINT fk_research_user_approval_id_from_research_user_approvals FOREIGN KEY (research_user_approval_id) REFERENCES management.research_user_approvals(id);


--
-- Name: archive_requests fk_research_user_approvals_from_archive_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.archive_requests
    ADD CONSTRAINT fk_research_user_approvals_from_archive_requests FOREIGN KEY (research_user_approval_id) REFERENCES management.research_user_approvals(id);


--
-- Name: data_requests fk_research_user_approvals_from_data_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.data_requests
    ADD CONSTRAINT fk_research_user_approvals_from_data_requests FOREIGN KEY (research_user_approval_id) REFERENCES management.research_user_approvals(id);


--
-- Name: export_requests fk_research_user_approvals_from_export_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.export_requests
    ADD CONSTRAINT fk_research_user_approvals_from_export_requests FOREIGN KEY (research_user_approval_id) REFERENCES management.research_user_approvals(id);


--
-- Name: import_requests fk_research_user_approvals_from_import_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.import_requests
    ADD CONSTRAINT fk_research_user_approvals_from_import_requests FOREIGN KEY (research_user_approval_id) REFERENCES management.research_user_approvals(id);


--
-- Name: resource_requests fk_research_user_approvals_from_resource_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.resource_requests
    ADD CONSTRAINT fk_research_user_approvals_from_resource_requests FOREIGN KEY (research_user_approval_id) REFERENCES management.research_user_approvals(id);


--
-- Name: organisations fk_research_user_creating_organisation; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisations
    ADD CONSTRAINT fk_research_user_creating_organisation FOREIGN KEY (created_by_user_id) REFERENCES management.users(id);


--
-- Name: organisation_members fk_research_user_creating_organisation_member; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_members
    ADD CONSTRAINT fk_research_user_creating_organisation_member FOREIGN KEY (created_by_user_id) REFERENCES management.users(id);


--
-- Name: organisation_members fk_research_user_from_organisation_member; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.organisation_members
    ADD CONSTRAINT fk_research_user_from_organisation_member FOREIGN KEY (research_user_id) REFERENCES management.research_users(id);


--
-- Name: department_members fk_research_users_from_organisation_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members
    ADD CONSTRAINT fk_research_users_from_organisation_members FOREIGN KEY (user_id) REFERENCES management.research_users(id);


--
-- Name: department_members_history fk_research_users_from_organisation_members_history; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_history
    ADD CONSTRAINT fk_research_users_from_organisation_members_history FOREIGN KEY (user_id) REFERENCES management.research_users(id);


--
-- Name: project_members_history fk_research_users_from_project_member_history; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_history
    ADD CONSTRAINT fk_research_users_from_project_member_history FOREIGN KEY (user_id) REFERENCES management.research_users(id);


--
-- Name: project_members fk_research_users_from_project_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members
    ADD CONSTRAINT fk_research_users_from_project_members FOREIGN KEY (user_id) REFERENCES management.research_users(id);


--
-- Name: requests fk_research_users_from_requests; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.requests
    ADD CONSTRAINT fk_research_users_from_requests FOREIGN KEY (created_by_user_id) REFERENCES management.research_users(id);


--
-- Name: request_updates fk_updated_by_user_from_users; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.request_updates
    ADD CONSTRAINT fk_updated_by_user_from_users FOREIGN KEY (updated_by_user_id) REFERENCES management.users(id);


--
-- Name: files fk_upload_by_user_from_users; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.files
    ADD CONSTRAINT fk_upload_by_user_from_users FOREIGN KEY (upload_by_user_id) REFERENCES management.users(id);


--
-- Name: admin_users fk_users_from_admin_users; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.admin_users
    ADD CONSTRAINT fk_users_from_admin_users FOREIGN KEY (id, type) REFERENCES management.users(id, type);


--
-- Name: department_members fk_users_from_organisation_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members
    ADD CONSTRAINT fk_users_from_organisation_members FOREIGN KEY (created_by_user_id) REFERENCES management.users(id);


--
-- Name: department_members_history fk_users_from_organisation_members_history; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.department_members_history
    ADD CONSTRAINT fk_users_from_organisation_members_history FOREIGN KEY (created_by_user_id) REFERENCES management.users(id);


--
-- Name: project_members_history fk_users_from_project_member_history; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members_history
    ADD CONSTRAINT fk_users_from_project_member_history FOREIGN KEY (created_by_user_id) REFERENCES management.users(id);


--
-- Name: project_members fk_users_from_project_members; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.project_members
    ADD CONSTRAINT fk_users_from_project_members FOREIGN KEY (created_by_user_id) REFERENCES management.users(id);


--
-- Name: research_users fk_users_from_research_users; Type: FK CONSTRAINT; Schema: management; Owner: sdecore
--

ALTER TABLE ONLY management.research_users
    ADD CONSTRAINT fk_users_from_research_users FOREIGN KEY (id, type) REFERENCES management.users(id, type);


--
-- PostgreSQL database dump complete
--

