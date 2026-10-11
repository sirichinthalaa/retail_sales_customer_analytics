# Data Quality Notes

## 1. Overview

This project uses sample retail data to analyze customers,
products, orders, payments, and returns.

Data quality is important because missing, duplicate, or
inconsistent records can affect SQL query results and lead
to incorrect business conclusions.

The following checks describe potential data quality issues
to investigate in the dataset.

## 2. Missing Values

Important fields may contain NULL values, such as customer
details, product information, payment information, or order
dates.

Potential impact:
- Missing customer names may affect customer reports.
- Missing product details may make product analysis difficult.
- Missing dates may affect monthly sales calculations.

Recommended checks:
- Identify NULL values in important columns.
- Determine whether each missing value is acceptable.
- Avoid replacing missing values without understanding
  their meaning.

## 3. Duplicate Records

Duplicate records can lead to incorrect counts and inflated
sales totals.

Recommended checks:
- Check whether customer IDs are unique in the customers
  table.
- Check whether product IDs are unique in the products table.
- Check whether order IDs are unique in the orders table.
- Verify the intended uniqueness rules for payment and
  return records.

Potential impact:

Duplicate order or order-item records may inflate revenue
and quantity calculations.

## 4. Referential Integrity

Related tables should contain valid references to existing
records.

Examples:
- Each order should reference an existing customer.
- Each order item should reference an existing order and
  product.
- Each payment should reference a valid order, if that is
  the intended schema.
- Each return should reference the appropriate order or
  order item, according to the schema.

Potential impact:

Invalid references can cause records to be excluded from
JOIN results or make reports incomplete.

## 5. Invalid Numeric Values

Numeric fields should contain values consistent with their
business meaning.

Examples:
- Product prices should not be negative.
- Order-item quantities should be positive unless the
  dataset explicitly uses another convention.
- Payment amounts should follow the expected rules for
  payment records.
- Refund amounts should follow the expected rules for
  returns and refunds.

Potential impact:

Invalid prices, quantities, or amounts can produce
incorrect revenue, payment, and refund calculations.

## 6. Date and Time Consistency

Order dates, payment dates, return dates, and customer
registration dates should use valid and consistent formats.

Recommended checks:
- Identify missing dates.
- Check for dates outside the expected dataset period.
- Check whether return dates precede the corresponding
  order dates.
- Confirm that monthly sales queries use the intended date
  column.

Potential impact:

Incorrect or missing dates may distort monthly trends and
customer registration reports.

## 7. Order and Payment Statuses

Status values should follow a consistent set of accepted
labels.

Examples might include:
- Pending
- Paid
- Failed
- Delivered
- Cancelled
- Returned

These are examples only. The actual valid values depend on
the columns and status conventions used in this dataset.

Recommended checks:
- List the distinct status values in each relevant table.
- Identify inconsistent spelling or capitalization.
- Check how cancelled, pending, and returned orders are
  handled in revenue calculations.

Potential impact:

Inconsistent statuses can cause records to be excluded
from filters or counted in the wrong category.

## 8. Revenue Calculation Considerations

Revenue calculations depend on the business definition
being used.

For this project, product-level sales revenue is calculated
using:

quantity * unit_price

Revenue totals should be interpreted carefully because:
- Cancelled or undelivered orders may need different
  treatment.
- Returned items may require adjustments.
- Discounts, taxes, shipping fees, and refunds may not be
  represented in the available columns.
- The unit_price stored in an order item may differ from
  the product's current listed price.

The analysis should clearly state which orders and records
are included in each calculation.

## 9. Join and Aggregation Risks

Joining tables with multiple records per order can duplicate
rows and inflate totals if the relationships are not
handled correctly.

Recommended checks:
- Understand the relationship between orders and order_items.
- Check whether an order can have multiple payment records.
- Check whether an order can have multiple return records.
- Aggregate data at the appropriate level before combining
  tables when necessary.
- Use DISTINCT only when it matches the intended counting
  logic.

Potential impact:

Incorrect joins can produce inaccurate revenue, payment,
return, or customer metrics.

## 10. Limitations

- The project uses sample data for SQL practice.
- The dataset may not represent actual retail business
  conditions.
- Some business factors, such as discounts, taxes, shipping
  costs, and customer acquisition costs, may not be available.
- Customer segmentation thresholds are illustrative and
  would need business validation.
- Findings depend on the completeness and accuracy of the
  available data.

## 11. Conclusion

Data quality checks help ensure that SQL analysis is more
reliable and easier to interpret.

Before making business recommendations, important issues
such as missing values, duplicate records, invalid
references, inconsistent statuses, and incorrect
calculations should be investigated.