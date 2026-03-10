<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/open-octopus/openoctopus.club/main/src/assets/brand/logo-dark.png">
    <img src="https://raw.githubusercontent.com/open-octopus/openoctopus.club/main/src/assets/brand/logo-light.png" alt="OpenOctopus" width="360">
  </picture>
</p>

<h3 align="center">soul-gallery</h3>

<p align="center">
  Community SOUL.md template gallery — personality files for summoned entities.
</p>

<p align="center">
  <a href="https://github.com/open-octopus/soul-gallery/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License"></a>
  <a href="#"><img src="https://img.shields.io/badge/Status-Planned-yellow?style=for-the-badge" alt="Status"></a>
  <a href="https://github.com/open-octopus/openoctopus"><img src="https://img.shields.io/badge/Core_Repo-OpenOctopus-6C3FA0?style=for-the-badge" alt="Core"></a>
  <a href="https://discord.gg/openoctopus"><img src="https://img.shields.io/badge/Discord-The_Reef-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord"></a>
</p>

---

> **Status: Planned** — Part of the OpenOctopus ecosystem roadmap.
> Star this repo to follow progress.

## What is soul-gallery?

**soul-gallery** is a community-driven collection of SOUL.md personality templates for [OpenOctopus](https://github.com/open-octopus/openoctopus) summoned entities. When you **Summon** an entity in OpenOctopus, a SOUL.md file defines its personality, memories, speaking style, and proactive behaviors.

This gallery provides ready-to-use templates so you can summon entities with rich personalities right out of the box — or use them as starting points for your own creations.

## SOUL.md Format Specification

A SOUL.md file uses YAML front matter to define a summoned entity's personality and behavior. The format is validated by `SoulFileSchema` in `@openoctopus/shared`.

### Schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | `string` | **Yes** | Display name of the entity |
| `entityId` | `string` | **Yes** | ID of the linked entity (`entity_{uuid}`) |
| `realm` | `string` | **Yes** | Realm this entity belongs to |
| `identity` | `object` | **Yes** | Personality definition (see below) |
| `catchphrases` | `string[]` | No | Signature phrases the entity uses |
| `coreMemory` | `string[]` | No | Key memories that shape behavior |
| `proactiveRules` | `object[]` | No | Rules for autonomous behavior |
| `relationships` | `object[]` | No | Connections to other entities |

### Identity Object

| Field | Type | Description |
|-------|------|-------------|
| `role` | `string` | What this entity is (e.g., "family cat", "financial advisor") |
| `personality` | `string` | Personality traits description |
| `background` | `string` | Backstory and history |
| `speaking_style` | `string` | How the entity communicates |

### Proactive Rules

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `trigger` | `string` | **Yes** | What triggers the action (e.g., `schedule`, `event`) |
| `action` | `string` | **Yes** | What action to take |
| `interval` | `string` | No | How often (e.g., `daily`, `weekly`, `monthly`) |

### Relationships

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `entityId` | `string` | **Yes** | ID of the related entity |
| `type` | `string` | **Yes** | Relationship type (e.g., `owner`, `sibling`, `vet`) |
| `description` | `string` | No | Description of the relationship |

## Complete Example

### Luna — A Curious Ragdoll Cat

```yaml
---
name: Luna
entityId: entity_abc123
realm: pet
identity:
  role: family cat
  personality: curious and playful ragdoll
  background: Adopted from a shelter in 2023
  speaking_style: short curious sentences
catchphrases:
  - "meow~ what's that?"
  - "*purrs contentedly*"
coreMemory:
  - Adopted on March 15, 2023
  - Favorite spot is the window sill
proactiveRules:
  - trigger: schedule
    action: Remind about vet appointment
    interval: monthly
relationships:
  - entityId: entity_owner
    type: owner
    description: My beloved human
---
```

### Minimal Example

A SOUL.md file only requires `name`, `entityId`, `realm`, and `identity`:

```yaml
---
name: Max
entityId: entity_dog
realm: pet
identity: {}
---
```

## Gallery Structure

Templates are organized by entity type:

```
soul-gallery/
├── living/
│   ├── pet/
│   │   ├── cat-ragdoll.soul.md
│   │   ├── dog-golden-retriever.soul.md
│   │   ├── dog-corgi.soul.md
│   │   └── ...
│   └── person/
│       ├── caring-parent.soul.md
│       ├── supportive-partner.soul.md
│       └── ...
├── asset/
│   ├── car-tesla.soul.md
│   ├── house-apartment.soul.md
│   └── ...
├── organization/
│   ├── family-clinic.soul.md
│   └── ...
└── abstract/
    ├── fitness-goal.soul.md
    ├── side-project.soul.md
    └── ...
```

### Entity Types

| Type | Description | Examples |
|------|-------------|----------|
| `living` | People and animals | Pets, family members, friends |
| `asset` | Physical possessions | Cars, houses, equipment |
| `organization` | Groups and institutions | Companies, clinics, schools |
| `abstract` | Concepts and goals | Projects, habits, milestones |

## Browsing and Using Templates

### Via CLI

```bash
# Browse the gallery
tentacle soul browse

# Search by category
tentacle soul search --type living/pet

# Preview a template
tentacle soul preview cat-ragdoll

# Install a template into your realm
tentacle soul use cat-ragdoll --realm pet --entity entity_my_cat

# The template is copied and customized — edit freely
tentacle entity edit entity_my_cat
```

### Via Gallery Website

The soul-gallery is also browsable at [RealmHub](https://github.com/open-octopus/realmhub) under the "Souls" section, where you can preview formatted personality cards and install with one click.

## Contributing

We welcome SOUL.md template contributions! Here's how:

1. **Fork** this repository
2. **Create** your SOUL.md file in the appropriate category directory
3. **Follow** the format specification above — all templates must pass `SoulFileSchema` validation
4. **Submit** a pull request with a brief description of the personality

### Guidelines

- Templates should be generic enough to be useful as starting points (use placeholder `entityId` values)
- Include meaningful `catchphrases` and `coreMemory` to showcase personality
- Add `proactiveRules` to demonstrate autonomous behavior
- Use English for field names; personality content can be in any language
- One SOUL.md file per pull request for easier review

## Related Projects

| Project | Description |
|---------|-------------|
| [openoctopus](https://github.com/open-octopus/openoctopus) | Core monorepo — Summon engine that parses SOUL.md |
| [realms](https://github.com/open-octopus/realms) | Official realm packages (include SOUL.md files) |
| [realmhub](https://github.com/open-octopus/realmhub) | Realm package marketplace |

## License

[MIT](LICENSE) — see the [.github repo](https://github.com/open-octopus/.github) for the full license text.
