# Project Invoice Template Migration Utility

Developed in-house by the **BQE CORE BI Engineering team** to preserve and restore project invoice-template assignments during migration.

## Problem

Projects may lose their Standard, Joint, and Manual invoice-template assignments during final migration. Internal `Project_ID` and `InvoiceTemplate_ID` values may also change, making the original database IDs unsuitable for restoring assignments.

Recreating these assignments manually can take hours for customers with hundreds or thousands of projects.

## Solution

The utility exports assignments using **ProjectID and template names**, then resolves their corresponding database IDs after migration.

### Workflow

1. **Export:** Run the export RDL in the source company and export the mapping to CSV.
2. **Prepare:** Use the converter to embed the CSV mapping as JSON inside a restore RDL.
3. **Preview:** Run the restore RDL in the destination company to validate matches and review proposed changes.
4. **Apply:** Confirm the target database and apply the validated assignments.

The generated restore RDL contains the mapping, so SQL Server does not need access to the original CSV file.

## Export Format

The CSV contains four columns:

| Column | Purpose |
|---|---|
| ProjectID | Identifies the project |
| StandardTemplateName | Standard invoice-template assignment |
| JointTemplateName | Joint invoice-template assignment |
| ManualTemplateName | Manual invoice-template assignment |

The mapping does not depend on legacy GUIDs.

## Restore Logic

The restore query:

- Matches each saved ProjectID to the destination project.
- Matches each saved template name to the destination invoice template.
- Uses the matched IDs to update the project's Standard, Joint, and Manual template assignments.

The same template can be assigned to multiple projects. However, multiple template records with the same name create an ambiguous match and require resolution before restoring.

## Safeguards

- Preview changes before applying updates.
- Missing or ambiguous matches block updates.
- Replacing an existing, different assignment requires explicit overwrite approval.
- Blank saved template values leave current assignments unchanged.
- Only invoice-template assignment fields are updated; projects and templates are not created or deleted.

## Usage Guidelines

- Test in a non-production company before production use.
- Keep a verified database backup and retain the original CSV.
- Ensure the required projects and invoice templates exist in the destination company.
- Review all validation messages before selecting Apply.
- Treat the CSV and generated restore RDL as company-specific data.
- Do not commit customer mappings, credentials, connection strings, or populated restore RDLs to the shared repository.

## Status

**QA in progress.** Production use is subject to validation and release approval.

## Developed By

**Saalim Wani, Farhat Shabir, Shahid Faheem, Innayat Hussain**  
BI Engineering
