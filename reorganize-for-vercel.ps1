# Folder Reorganization Script for Vercel
# Run this script to reorganize your project structure for Vercel deployment
# Save as: reorganize-for-vercel.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SnapNEarn - Vercel Structure Reorganization" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$originalLocation = Get-Location

# Step 1: Create new directories
Write-Host "[1/7] Creating new directory structure..." -ForegroundColor Yellow

if (!(Test-Path "api")) {
    New-Item -ItemType Directory -Name "api" | Out-Null
    Write-Host "✓ Created 'api' folder" -ForegroundColor Green
}

if (!(Test-Path "apps")) {
    New-Item -ItemType Directory -Name "apps" | Out-Null
    Write-Host "✓ Created 'apps' folder" -ForegroundColor Green
}

if (!(Test-Path "apps/dashboard")) {
    New-Item -ItemType Directory -Path "apps" -Name "dashboard" -ErrorAction SilentlyContinue | Out-Null
}

if (!(Test-Path "shared")) {
    New-Item -ItemType Directory -Name "shared" | Out-Null
    Write-Host "✓ Created 'shared' folder" -ForegroundColor Green
}

# Step 2: Create subdirectories in api
Write-Host "[2/7] Creating API subdirectories..." -ForegroundColor Yellow

$apiDirs = @("models", "middleware", "utils")
foreach ($dir in $apiDirs) {
    $path = "api/$dir"
    if (!(Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
        Write-Host "✓ Created 'api/$dir' folder" -ForegroundColor Green
    }
}

# Step 3: Copy backend files to api
Write-Host "[3/7] Copying backend files to api folder..." -ForegroundColor Yellow

if (Test-Path "backend") {
    # Copy package.json
    if (Test-Path "backend/package.json") {
        Copy-Item "backend/package.json" -Destination "api/package.json" -Force
        Write-Host "✓ Copied package.json to api/" -ForegroundColor Green
    }

    # Copy models
    if (Test-Path "backend/models") {
        Get-ChildItem "backend/models" -Filter "*.js" | ForEach-Object {
            Copy-Item $_.FullName -Destination "api/models/" -Force
        }
        Write-Host "✓ Copied models to api/models/" -ForegroundColor Green
    }

    # Copy utils
    if (Test-Path "backend/utils") {
        Get-ChildItem "backend/utils" -Filter "*.js" | ForEach-Object {
            Copy-Item $_.FullName -Destination "api/utils/" -Force
        }
        Write-Host "✓ Copied utils to api/utils/" -ForegroundColor Green
    }

    # Copy middleware if exists
    if (Test-Path "backend/middleware") {
        Get-ChildItem "backend/middleware" -Filter "*.js" | ForEach-Object {
            Copy-Item $_.FullName -Destination "api/middleware/" -Force
        }
        Write-Host "✓ Copied middleware to api/middleware/" -ForegroundColor Green
    }
} else {
    Write-Host "⚠ 'backend' folder not found. Skipping backend files." -ForegroundColor Yellow
}

# Step 4: Move frontend apps
Write-Host "[4/7] Organizing frontend applications..." -ForegroundColor Yellow

if ((Test-Path "officer-dashboard") -and !(Test-Path "apps/dashboard")) {
    Move-Item "officer-dashboard" -Destination "apps/dashboard" -ErrorAction SilentlyContinue
    Write-Host "✓ Moved officer-dashboard to apps/dashboard" -ForegroundColor Green
}

if ((Test-Path "website") -and !(Test-Path "apps/website")) {
    Move-Item "website" -Destination "apps/website" -ErrorAction SilentlyContinue
    Write-Host "✓ Moved website to apps/website" -ForegroundColor Green
}

if ((Test-Path "mobile") -and !(Test-Path "apps/mobile")) {
    Move-Item "mobile" -Destination "apps/mobile" -ErrorAction SilentlyContinue
    Write-Host "✓ Moved mobile to apps/mobile" -ForegroundColor Green
}

# Step 5: Copy configuration files
Write-Host "[5/7] Setting up configuration files..." -ForegroundColor Yellow

# These should already be created, but check
if (Test-Path "vercel.json") {
    Write-Host "✓ vercel.json already exists" -ForegroundColor Green
} else {
    Write-Host "⚠ vercel.json not found. Please create it manually." -ForegroundColor Yellow
}

if (Test-Path "package.json.vercel") {
    Write-Host "✓ package.json.vercel ready (rename to package.json when ready)" -ForegroundColor Green
}

# Step 6: Create .env.example if it doesn't exist
Write-Host "[6/7] Creating environment configuration..." -ForegroundColor Yellow

if (!(Test-Path ".env.example")) {
    $envContent = @"
# MongoDB
MONGODB_URI=your_mongodb_connection_string

# JWT
JWT_SECRET=your_jwt_secret_key

# Cloudinary
CLOUDINARY_NAME=your_cloudinary_name
CLOUDINARY_API_KEY=your_cloudinary_api_key
CLOUDINARY_API_SECRET=your_cloudinary_api_secret

# Node Environment
NODE_ENV=production

# Server Port (for local development)
PORT=5000
"@
    Set-Content -Path ".env.example" -Value $envContent
    Write-Host "✓ Created .env.example" -ForegroundColor Green
} else {
    Write-Host "✓ .env.example already exists" -ForegroundColor Green
}

# Step 7: Summary
Write-Host "[7/7] Reorganization complete!" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "NEXT STEPS:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "1. Review the new folder structure:"
Write-Host "   - api/              (Backend serverless functions)"
Write-Host "   - apps/dashboard/   (Officer Dashboard)"
Write-Host "   - apps/website/     (Landing Website)"
Write-Host "   - apps/mobile/      (Mobile App)"
Write-Host "   - shared/           (Shared utilities)"
Write-Host ""
Write-Host "2. Update package.json:"
Write-Host "   - Backup current package.json"
Write-Host "   - Replace with content from package.json.vercel"
Write-Host ""
Write-Host "3. Update import paths in your code"
Write-Host "   - Check all imports after migration"
Write-Host ""
Write-Host "4. Install dependencies:"
Write-Host "   npm install"
Write-Host ""
Write-Host "5. Test locally:"
Write-Host "   vercel dev"
Write-Host ""
Write-Host "6. Deploy to Vercel:"
Write-Host "   vercel --prod"
Write-Host ""
Write-Host "For more info, see:"
Write-Host "   - VERCEL_DEPLOYMENT_GUIDE.md"
Write-Host "   - FOLDER_STRUCTURE_MIGRATION.md"
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
