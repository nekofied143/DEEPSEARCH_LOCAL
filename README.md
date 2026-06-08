# Smart Deep Search Tool v2

A lightweight PowerShell-based document search utility for Windows that uses the Windows Search Index to quickly find documents by content.

## Features

* Fast full-text search using the Windows Search Index
* Searches document contents, not just file names
* Supports:

  * PDF (`.pdf`)
  * Microsoft Word (`.docx`)
  * Microsoft Excel (`.xlsx`)
* Interactive command-line interface
* Open one or multiple search results directly
* No third-party dependencies required
* Simple and portable

## Requirements

* Windows 10 or Windows 11
* Windows Search service enabled and indexing configured
* PowerShell 5.1 or later

## Installation

1. Download or clone this repository.

```bash
git clone https://github.com/nekofied143/DEEPSEARCH_LOCAL.git
```

2. Place the following files in the same folder:

```text
SearchTool.cmd
DeepSearch.ps1
```

## Usage

Run:

```cmd
SearchTool.cmd
```

Enter a keyword when prompted:

```text
Enter keyword: invoice
```

The tool will search indexed documents and display matching results.

Example:

```text
1. C:\Documents\Invoice_2025.pdf
2. D:\Reports\Annual_Report.docx
3. C:\Finance\Budget.xlsx
```

To open documents:

```text
1 3
```

This opens results #1 and #3.

Additional commands:

```text
S
```

Search again.

```text
E
```

Exit the application.

## How It Works

The tool queries the Windows Search Index using:

```sql
SELECT System.ItemPathDisplay
FROM SYSTEMINDEX
WHERE FREETEXT('keyword')
```

Results are filtered to include only:

```text
C:\
D:\
.pdf
.docx
.xlsx
```

Matching documents can then be opened directly from the interface.

## Notes

* Only indexed files can be found.
* If a folder is not indexed by Windows Search, documents inside it will not appear in results.
* Search performance depends on the state of the Windows Search Index.

## License

MIT License

## Author

Created with PowerShell to provide a fast and simple way to search document contents using Windows Search.
