# RDL Diff — Offline Report Comparison

Compare two versions of an SSRS RDL file to review changes to queries, expressions, parameters, layout, styles, and subreport references. Header, Body, Footer, and Report-level summaries help locate changes quickly.

**Tool:** `RDL_Diff_Offline_Header_Body_Footer.html`  
**Edition:** Offline v1.1

## Getting started

1. Download the HTML file and open it in Chrome, Edge, or Firefox with JavaScript enabled.
2. Under **Original Report**, load the earlier RDL using **Browse**, drag and drop, or **Paste XML**.
3. Under **Revised Report**, load the updated RDL using the same options. When pasting, provide the complete XML and click **Use this XML**.
4. Select any comparison options you need, then click **Compare files**.
5. Review the area summaries and use **XML diff** or **Change list** to inspect changes.
6. Click **Export change report** to download the comparison as an HTML report.

No installation, sign-in, internet connection, SQL Server connection, or Report Builder installation is required. Use **Try a sample comparison** to explore the interface before loading your reports.

## Main features

- Side-by-side comparison of the original and revised XML, with changed text highlighted.
- Structural change counts for modified, added, and removed content.
- Separate area filters for Header, Body, Footer, and Report-level settings.
- Category and named-component filters to narrow the review.
- Search by text or XML path, line wrapping, change navigation, and pagination.
- Optional exclusion of designer metadata and XML comments.
- Downloadable, standalone HTML change report.

## Report areas

| Area | What it includes |
| --- | --- |
| Header | XML within the actual `<PageHeader>` element. |
| Body | XML within `<Body>`, including report items and nested content. |
| Footer | XML within the actual `<PageFooter>` element. |
| Report-level | Datasets, parameters, report code, data sources, page settings, and other XML outside these areas. |

Areas follow XML ancestry, not textbox names or visual placement. For example, a rectangle used as an invoice header inside `<Body>` is classified as **Body**.

Each area displays **Changed**, **No changes**, or **Not present**. Area counts cover the full comparison under the selected comparison options. A container spanning multiple areas can count once in each area, so adding the area totals may exceed the overall structural change count.

Report-level changes can affect the output of any area. An unchanged Header summary does not prove that the rendered header will remain unchanged if its dataset or parameters change.

## Category filters

| Category | Content to review |
| --- | --- |
| All XML | The complete comparison. |
| Datasets | Query text, fields, query parameters, and other dataset definitions. |
| Layout & styles | Report items, grouping and sorting definitions, formatting, sizing, positioning, and layout expressions. |
| Parameters | Report parameter definitions and parameter layout. |
| Subreports | Subreport references and parameter mappings in the loaded files. |
| Report code | Embedded code, code modules, and class definitions. |
| Data sources | Connection settings and data source references. |
| Metadata & other | Designer metadata and other XML outside the categories above. |

Area and category filters work together. Where available, use the component dropdown to focus on a named dataset, parameter, textbox, tablix, or other component.

## Reading the results

**XML diff** shows normalized XML with original content on the left and revised content on the right. Red marks original changed or removed lines; green marks revised changed or added lines. A modification can therefore show both colors.

**Change list** shows individual structural changes, their XML paths, area labels, and original/revised values. Counts represent structural changes, not the number of changed lines or business requirements. Adding or removing a whole XML subtree can appear as one structural change.

| Control | Behavior |
| --- | --- |
| Changes only | Shows changed XML with nearby context. Turn it off to view all XML in the current scope. |
| Wrap lines | Wraps long XML lines in the viewer. |
| Search | Filters matching text, XML paths, or area labels. |
| Previous / Next change | Navigates change blocks in the XML view. |
| Page arrows | Navigates paginated results. |
| Swap button | Exchanges the original and revised inputs; run the comparison again. |
| Clear | Clears the loaded files and results. |

Displayed line numbers refer to the tool's formatted XML, so they may differ from line numbers in the source file.

## Comparison options and normalization

Both ignore options are off by default:

- **Ignore designer metadata (rd:)** excludes elements and attributes in the SSRS report designer namespace.
- **Ignore XML comments** excludes XML comments.

If you change these options, run **Compare files** again.

The tool normalizes XML indentation and attribute order. XML declarations and some equivalent XML representations do not produce changes. Text inside SQL queries and expressions is preserved for comparison, so changes to that text can still appear even when execution would produce the same result.

“No XML differences” means the files match under the current options; it does not necessarily mean their original bytes are identical.

## Exporting a change report

**Export change report** downloads `RDL_Diff_Report.html`, containing:

- Original and revised filenames and the generation timestamp.
- Comparison options and the total structural change count.
- Header, Body, Footer, and Report-level summaries.
- Structural changes with before/after values and XML paths.
- Side-by-side XML differences with surrounding context.

The export includes **all sections**, regardless of the active screen filters or search. The comparison options still apply. Open the exported file in a browser to review it or use the browser's print function.

## Local processing and file handling

The tool processes files in browser memory. It makes no network requests and uses no cookies or persistent browser storage. It does not modify the input RDL files. Refreshing or closing the page clears the working comparison; exporting explicitly saves a separate report to your device.

Exported reports contain XML excerpts and values from the source files, which may include connection settings or other internal information. Review the contents before sharing.

## Limits and troubleshooting

| Situation | Explanation or action |
| --- | --- |
| Compare files is disabled | Load valid XML on both sides. |
| Invalid XML or empty XML | Use a complete, well-formed RDL/XML document. |
| File exceeds the size limit | Each input must fit within the 12 MiB limit, shown as “12 MB” in the interface. Decoded text is also checked. |
| Could not decode the file | Save it as UTF-8 or UTF-16 XML and try again. |
| DOCTYPE rejected | XML containing a DOCTYPE/DTD is unsupported. |
| XML is too large or deeply nested | The tool limits formatted XML to 180,000 lines per model and nesting to 240 levels. |
| Large changed blocks are grouped | The viewer uses a coarser comparison to remain responsive; XML content is still included in the comparison. |
| Expected header change appears under Body | The item belongs to `<Body>` in the RDL structure. |
| A linked subreport's internal changes are missing | Load the original and revised subreport RDLs separately. Linked files are not loaded automatically. |

Generic XML can also be compared, but RDL area classification only applies to recognized Report structure; other XML is treated as Report-level.

This tool compares report definitions. It does not render reports, execute SQL or expressions, validate RDL against an SSRS schema, merge files, or confirm business results. After reviewing a change, validate the revised report in Report Builder or CORE using suitable test data.
