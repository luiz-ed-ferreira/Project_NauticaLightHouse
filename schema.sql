-- Schema gerado automaticamente LH Nautical

CREATE TABLE "addresses" (
    "id" TEXT,
    "customer_id" TEXT,
    "address_type" TEXT,
    "postal_code" TEXT,
    "street" TEXT,
    "number" INTEGER,
    "complement" TEXT,
    "district" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "is_primary" TEXT
);

CREATE TABLE "attributes" (
    "id" TEXT,
    "name" TEXT,
    "data_type" TEXT
);

CREATE TABLE "brands" (
    "id" TEXT,
    "name" TEXT,
    "country" TEXT,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "categories" (
    "id" TEXT,
    "name" TEXT,
    "slug" TEXT,
    "parent_category_id" TEXT,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "customers" (
    "id" TEXT,
    "person_type" TEXT,
    "legal_name" TEXT,
    "trade_name" TEXT,
    "tax_id" TEXT,
    "state_registration" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "employees" (
    "id" TEXT,
    "full_name" TEXT,
    "cpf" TEXT,
    "email" TEXT,
    "role" TEXT,
    "primary_location_id" TEXT,
    "hire_date" DATE,
    "termination_date" DATE,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "fiscal_invoices" (
    "id" TEXT,
    "order_id" TEXT,
    "nfe_number" TEXT,
    "nfe_access_key" INTEGER,
    "series" INTEGER,
    "issued_at" TIMESTAMP,
    "status" TEXT,
    "total_amount" NUMERIC,
    "xml_storage_uri" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "goods_receipt_items" (
    "id" TEXT,
    "goods_receipt_id" TEXT,
    "purchase_order_item_id" TEXT,
    "quantity_received" NUMERIC
);

CREATE TABLE "goods_receipts" (
    "id" TEXT,
    "purchase_order_id" TEXT,
    "received_by_employee_id" TEXT,
    "received_at" TIMESTAMP,
    "notes" TEXT,
    "created_at" TIMESTAMP
);

CREATE TABLE "locations" (
    "id" TEXT,
    "name" TEXT,
    "location_type" TEXT,
    "postal_code" TEXT,
    "street" TEXT,
    "number" INTEGER,
    "complement" TEXT,
    "district" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "order_items" (
    "id" TEXT,
    "order_id" TEXT,
    "product_variant_id" TEXT,
    "quantity" INTEGER,
    "unit_price" NUMERIC,
    "icms_rate" NUMERIC,
    "ipi_rate" NUMERIC,
    "line_total" NUMERIC
);

CREATE TABLE "orders" (
    "id" TEXT,
    "order_number" TEXT,
    "channel" TEXT,
    "customer_id" TEXT,
    "salesperson_id" TEXT,
    "location_id" TEXT,
    "status" TEXT,
    "subtotal" NUMERIC,
    "discount_amount" NUMERIC,
    "total" NUMERIC,
    "placed_at" TIMESTAMP,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "payments" (
    "id" TEXT,
    "order_id" TEXT,
    "method" TEXT,
    "installments" INTEGER,
    "amount" NUMERIC,
    "status" TEXT,
    "paid_at" TIMESTAMP,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "product_suppliers" (
    "product_variant_id" TEXT,
    "supplier_id" TEXT,
    "supplier_sku" TEXT,
    "last_quoted_cost" NUMERIC,
    "lead_time_days" INTEGER,
    "is_preferred" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "product_variants" (
    "id" TEXT,
    "product_id" TEXT,
    "sku" TEXT,
    "barcode_ean" INTEGER,
    "sale_price" NUMERIC,
    "cost_price" NUMERIC,
    "weight_kg" NUMERIC,
    "icms_rate" NUMERIC,
    "ipi_rate" NUMERIC,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "products" (
    "id" TEXT,
    "name" TEXT,
    "description" TEXT,
    "brand_id" TEXT,
    "category_id" TEXT,
    "ncm_code" INTEGER,
    "unit_of_measure" TEXT,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "purchase_order_items" (
    "id" TEXT,
    "purchase_order_id" TEXT,
    "product_variant_id" TEXT,
    "quantity_ordered" INTEGER,
    "unit_cost" NUMERIC,
    "line_total" NUMERIC
);

CREATE TABLE "purchase_orders" (
    "id" TEXT,
    "po_number" TEXT,
    "supplier_id" TEXT,
    "buyer_id" TEXT,
    "destination_location_id" TEXT,
    "status" TEXT,
    "currency" TEXT,
    "subtotal" NUMERIC,
    "total" NUMERIC,
    "placed_at" TIMESTAMP,
    "expected_delivery_at" DATE,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "return_items" (
    "id" TEXT,
    "return_id" TEXT,
    "order_item_id" TEXT,
    "quantity" NUMERIC,
    "action" TEXT,
    "exchange_variant_id" TEXT,
    "unit_refund_amount" NUMERIC
);

CREATE TABLE "returns" (
    "id" TEXT,
    "return_number" TEXT,
    "order_id" TEXT,
    "customer_id" TEXT,
    "received_at_location_id" TEXT,
    "status" TEXT,
    "reason" TEXT,
    "total_refund_amount" NUMERIC,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "stock_levels" (
    "product_variant_id" TEXT,
    "location_id" TEXT,
    "quantity_on_hand" NUMERIC,
    "reorder_point" TEXT,
    "updated_at" TIMESTAMP
);

CREATE TABLE "stock_movements" (
    "id" TEXT,
    "product_variant_id" TEXT,
    "location_id" TEXT,
    "movement_type" TEXT,
    "quantity" NUMERIC,
    "reference_table" TEXT,
    "reference_id" TEXT,
    "employee_id" TEXT,
    "notes" TEXT,
    "occurred_at" TIMESTAMP,
    "created_at" TIMESTAMP
);

CREATE TABLE "suppliers" (
    "id" TEXT,
    "legal_name" TEXT,
    "trade_name" TEXT,
    "country" TEXT,
    "tax_id" TEXT,
    "tax_id_type" TEXT,
    "email" TEXT,
    "phone" INTEGER,
    "contact_name" TEXT,
    "is_active" TEXT,
    "created_at" TIMESTAMP,
    "updated_at" TIMESTAMP
);

CREATE TABLE "variant_attribute_values" (
    "product_variant_id" TEXT,
    "attribute_id" TEXT,
    "value" TEXT
);
