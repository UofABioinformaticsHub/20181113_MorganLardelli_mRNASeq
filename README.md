- Files L001-L004 were merged directly when exporting from basespace
- Filepaths with spaces (i.e. `/basespacePath/File (2)/Files` were not combined with other replicates during export
    + This can occur later (after loading counts into R)
- As reads are 1x75, no deduplication was performed

