# Folder Structure Reorganization for Vercel

This guide explains how to reorganize your current project structure to be Vercel-optimized.

## Current Structure → Vercel Structure

### Option 1: Recommended (Serverless Backend)

```
BEFORE:
SnapNEarn-App-main/
├── backend/
│   ├── server.js
│   ├── routes/
│   │   ├── auth.js
│   │   ├── reports.js
│   │   ├── users.js
│   │   ├── violations.js
│   │   ├── payments.js
│   │   └── police.js
│   ├── models/
│   ├── utils/
│   ├── package.json
│   └── requirements.txt
├── officer-dashboard/
├── website/
├── mobile/
└── package.json

AFTER:
SnapNEarn-App-main/
├── api/                          ← Create new folder
│   ├── package.json             ← Copy from backend
│   ├── middleware/              ← Move from backend/
│   ├── models/                  ← Move from backend/
│   ├── utils/                   ← Move from backend/
│   ├── auth.js                  ← Convert routes to serverless
│   ├── reports.js
│   ├── users.js
│   ├── violations.js
│   ├── payments.js
│   ├── police.js
│   └── config.js                ← Database connection
├── apps/
│   ├── dashboard/               ← Move from officer-dashboard/
│   ├── website/                 ← Keep as is
│   └── mobile/                  ← Keep as is (local dev only)
├── shared/                       ← Optional: shared types & utils
│   ├── types.js
│   └── constants.js
├── package.json                 ← Root monorepo config
├── vercel.json                  ← Vercel deployment config
└── VERCEL_DEPLOYMENT_GUIDE.md
```

## Step-by-Step Migration

### Step 1: Create New API Folder Structure

```powershell
# Create api folder
mkdir api
cd api

# Copy package.json from backend and modify it
copy ..\backend\package.json .
```

### Step 2: Move Backend Files

```powershell
# Move subdirectories
move ..\backend\models models
move ..\backend\utils utils
move ..\backend\middleware middleware

# Copy database connection setup
copy ..\backend\server.js .\config.js
```

### Step 3: Create Serverless Route Files

Create individual route files in the `api/` folder:
- `api/auth.js`
- `api/reports.js`
- `api/users.js`
- etc.

Each file should export a handler function. (See sample files below)

### Step 4: Reorganize Frontend Apps

```powershell
# Create apps folder if not exists
mkdir apps

# Move existing apps
move officer-dashboard apps/dashboard
move website apps/website
move mobile apps/mobile
```

### Step 5: Update Root package.json

Replace the root `package.json` with the Vercel-optimized version.

### Step 6: Update Import Paths

Update all import paths in your code:
- Routes importing models: `const User = require('../models/User')`
- Utils imports: `const { someUtil } = require('../utils')`

## Key Changes Needed

### 1. API Routes → Serverless Functions

**Before (Express Route):**
```javascript
// backend/routes/auth.js
const express = require('express');
const router = express.Router();

router.post('/login', (req, res) => {
  // logic
  res.json({ success: true });
});

module.exports = router;
```

**After (Vercel Serverless):**
```javascript
// api/auth.js
module.exports = async (req, res) => {
  if (req.method === 'POST' && req.url.includes('/login')) {
    // logic
    res.json({ success: true });
  }
};
```

### 2. Database Connection

Create a centralized connection file:

**api/config.js:**
```javascript
const mongoose = require('mongoose');

let cached = global.mongoose;

if (!cached) {
  cached = global.mongoose = { conn: null };
}

async function connectDB() {
  if (cached.conn) {
    return cached.conn;
  }

  const conn = await mongoose.connect(process.env.MONGODB_URI);
  cached.conn = conn;
  return conn;
}

module.exports = connectDB;
```

### 3. Environment Variables

Create `.env.local` for local development:
```
MONGODB_URI=your_connection_string
JWT_SECRET=your_secret
CLOUDINARY_NAME=your_name
CLOUDINARY_API_KEY=your_key
CLOUDINARY_API_SECRET=your_secret
```

## File Structure After Migration

```
SnapNEarn-App-main/
├── api/
│   ├── auth.js                  (500 lines max per file)
│   ├── reports.js
│   ├── users.js
│   ├── violations.js
│   ├── payments.js
│   ├── police.js
│   ├── config.js                (DB connection)
│   ├── middleware/
│   │   ├── auth-middleware.js
│   │   └── validators.js
│   ├── models/
│   │   ├── User.js
│   │   ├── Report.js
│   │   ├── Violation.js
│   │   ├── Payment.js
│   │   └── index.js
│   ├── utils/
│   │   ├── notifications.js
│   │   └── validators.js
│   └── package.json
│
├── apps/
│   ├── dashboard/
│   │   ├── src/
│   │   ├── dist/                (build output)
│   │   ├── package.json
│   │   ├── vite.config.ts
│   │   └── tsconfig.json
│   ├── website/
│   │   ├── src/
│   │   ├── dist/                (build output)
│   │   ├── package.json
│   │   └── index.html
│   └── mobile/
│       ├── src/
│       ├── package.json
│       └── app.config.js
│
├── shared/                       (Optional)
│   ├── types/
│   │   └── index.ts
│   ├── constants/
│   │   └── index.ts
│   └── utils/
│       └── index.ts
│
├── .env.example
├── .env.local                   (local development)
├── .gitignore
├── package.json                 (monorepo root)
├── vercel.json                  (Vercel config)
├── tsconfig.json                (if using TypeScript)
└── VERCEL_DEPLOYMENT_GUIDE.md
```

## Vercel File Size Limits

- **Max function size**: 50MB (zipped)
- **Recommended per function**: < 1MB
- **Max deployment size**: 100GB (Enterprise)

## Important Notes

1. **No file system access** in serverless functions - use databases only
2. **No background processes** - use webhooks or scheduled tasks
3. **Environment variables** must be set in Vercel dashboard
4. **Cold start**: First request may be slower (usually <1s)
5. **Execution time**: Default max 30s per request (upgrade for more)

## Testing Locally

```bash
# Install Vercel CLI
npm install -g vercel

# Test locally
vercel dev

# Deploy to staging
vercel --prod --token <your_token>
```

## Rollback

If something goes wrong:
```bash
# List deployments
vercel ls

# Rollback to previous
vercel rollback
```

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Module not found | Check relative paths in imports |
| Port already in use | Change port in config or kill process |
| Env var undefined | Add to Vercel Settings → Environment Variables |
| Build fails | Check build script in package.json |
| Timeout | Optimize code or upgrade Vercel plan |
| CORS error | Update CORS config in api files |

