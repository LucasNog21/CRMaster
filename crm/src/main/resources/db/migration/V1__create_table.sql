
CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    active BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE customers  (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(30),
    company VARCHAR(200),
    segment VARCHAR(100),
    avatar_url TEXT,
    active BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    created_by BIGINT,
    CONSTRAINT fk_customer
    FOREIGN KEY (id)
    REFERENCES users(id)
);

CREATE TABLE leads (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    assigned_to BIGINT NOT NULL,
    title VARCHAR(300) NOT NULL,
    status VARCHAR(30) NOT NULL,
    source VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    CONSTRAINT fk_leads_customer
       FOREIGN KEY (customer_id) REFERENCES customers(id),
    CONSTRAINT fk_leads_assigned_to
       FOREIGN KEY (assigned_to) REFERENCES users(id)
);


CREATE TABLE deals (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lead_id BIGINT NOT NULL,
    assigned_to BIGINT NOT NULL,
    title VARCHAR(300) NOT NULL,
    stage VARCHAR(30) NOT NULL,
    value NUMERIC(15,2),
    expected_close DATE,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    CONSTRAINT fk_deals_lead
       FOREIGN KEY (lead_id) REFERENCES leads(id),
    CONSTRAINT fk_deals_assigned_to
       FOREIGN KEY (assigned_to) REFERENCES users(id)
);

CREATE TABLE deal_attachments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    deal_id BIGINT NOT NULL,
    uploaded_by BIGINT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_url TEXT NOT NULL,
    mime_type VARCHAR(127) NOT NULL,
    file_size BIGINT NOT NULL,
    uploaded_at TIMESTAMP NOT NULL,

    CONSTRAINT fk_attachments_deal
      FOREIGN KEY (deal_id) REFERENCES deals(id),
    CONSTRAINT fk_attachments_uploaded_by
      FOREIGN KEY (uploaded_by) REFERENCES users(id)
);


CREATE TABLE activities (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    assigned_to BIGINT NOT NULL,
    type VARCHAR(30) NOT NULL,
    title VARCHAR(300) NOT NULL,
    description TEXT,
    scheduled_at TIMESTAMP,
    done BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL,

    CONSTRAINT fk_activities_customer
        FOREIGN KEY (customer_id) REFERENCES customers(id),
    CONSTRAINT fk_activities_assigned_to
        FOREIGN KEY (assigned_to) REFERENCES users(id)
);


CREATE TABLE audit_log (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    entity_name VARCHAR(100) NOT NULL,
    entity_id BIGINT NOT NULL,
    operation VARCHAR(10) NOT NULL,
    performed_by BIGINT NOT NULL,
    old_values JSONB,
    new_values JSONB,
    performed_at TIMESTAMP NOT NULL,

    CONSTRAINT fk_audit_log_performed_by
       FOREIGN KEY (performed_by) REFERENCES users(id)
);