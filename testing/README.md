## HowTo

### ▶ Clean rebuild tests

**With GCS:**
```bash
./recompile-tests.sh --gcs=enabled
```

**Without GCS:**
```bash
./recompile-tests.sh --gcs=disabled (default)
```

or just

```bash
./recompile-tests.sh
```

### ▶ Deliver artifacts → FVP

```bash
./deploy-to-fvp.sh
```

### ▶ Run a batch of tests

```bash
./test-on-fvp.sh env00,posix_timers
```

### ▶ Recompile ▶ Deploy → FVP
Do do so in a one run, using a single command:

**With GCS:**
```bash
./deploy-to-fvp.sh --gcs=enabled
```

**Without GCS:**
```bash
./deploy-to-fvp.sh
```
