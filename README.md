# Starter App

A modern web application built with the latest technologies and best practices.

## Tech Stack

- **Framework**: [Next.js 15](https://nextjs.org/) - React framework with App Router
- **Language**: [TypeScript](https://www.typescriptlang.org/) - Type-safe JavaScript
- **Styling**: [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS framework
- **UI Components**: [shadcn/ui](https://ui.shadcn.com/) - Beautifully designed components
- **Database ORM**: [Prisma](https://www.prisma.io/) - Next-generation ORM for PostgreSQL
- **Package Manager**: [pnpm](https://pnpm.io/) - Fast, disk space efficient
- **Code Quality**: ESLint + Prettier

## Getting Started

### Prerequisites

- Node.js 18+ installed
- PostgreSQL database (local or remote)
- pnpm installed (`npm install -g pnpm`)

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd Starter
```

2. Install dependencies:
```bash
pnpm install
```

3. Set up your database:

**Quick Setup (Interactive):**
```bash
pnpm db:setup
```

**Manual Setup:**
```bash
cp .env.example .env
# Edit .env and add your database URL (see DATABASE_SETUP.md for options)
pnpm db:generate
pnpm db:push
```

📖 **See [DATABASE_SETUP.md](./DATABASE_SETUP.md) for detailed instructions on:**
- Supabase (Recommended - Free)
- Vercel Postgres
- Railway
- Local PostgreSQL

4. Start the development server:
```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Available Scripts

- `pnpm dev` - Start development server
- `pnpm build` - Build for production
- `pnpm start` - Start production server
- `pnpm lint` - Run ESLint
- `pnpm format` - Format code with Prettier
- `pnpm db:generate` - Generate Prisma Client
- `pnpm db:push` - Push schema changes to database
- `pnpm db:migrate` - Run database migrations
- `pnpm db:studio` - Open Prisma Studio

## Project Structure

```
├── src/
│   ├── app/              # Next.js App Router pages
│   │   ├── layout.tsx    # Root layout
│   │   ├── page.tsx      # Home page
│   │   └── globals.css   # Global styles
│   ├── components/       # React components
│   │   └── ui/          # shadcn/ui components
│   └── lib/             # Utility functions
│       ├── prisma.ts    # Prisma client singleton
│       └── utils.ts     # Helper functions
├── prisma/
│   └── schema.prisma    # Database schema
├── public/              # Static assets
└── ...config files
```

## Adding shadcn/ui Components

To add new shadcn/ui components:

```bash
npx shadcn@latest add button
npx shadcn@latest add card
npx shadcn@latest add dialog
```

Browse all components at [ui.shadcn.com](https://ui.shadcn.com).

## Database

This project uses Prisma with PostgreSQL. The example schema includes a basic `User` model.

To modify the schema:

1. Edit `prisma/schema.prisma`
2. Run `pnpm db:push` for development or `pnpm db:migrate` for production
3. The Prisma Client will be automatically regenerated

## Deployment

### Vercel (Recommended)

1. Push your code to GitHub
2. Import your repository on [Vercel](https://vercel.com)
3. Add your environment variables
4. Deploy!

Vercel will automatically detect Next.js and configure the build settings.

### Other Platforms

This app can be deployed to any platform that supports Node.js:

- Netlify
- Railway
- Render
- AWS
- Google Cloud
- Azure

Make sure to:
1. Set environment variables
2. Run database migrations
3. Build the project (`pnpm build`)

## Learn More

- [Next.js Documentation](https://nextjs.org/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [shadcn/ui Documentation](https://ui.shadcn.com)
- [Prisma Documentation](https://www.prisma.io/docs)

## License

MIT
