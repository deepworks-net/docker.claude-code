# Using Claude Code with Max Plan

This guide explains how to use Claude Code with your Anthropic Max plan subscription in this Docker setup.

## Max Plan Benefits

- **Unified Experience**: Access both Claude (web, desktop, mobile) and Claude Code (terminal) with one subscription
- **Shared Usage**: Usage limits are shared across both Claude and Claude Code
- **Flexible Tiers**: Choose between 5x Pro ($100/month) or 20x Pro ($200/month) based on your needs

## Authentication with Max Plan

When using Claude Code with your Max plan, you'll need to log in with the same credentials you use for Claude.ai:

1. Start the container using `docker-compose up -d --build`
2. Inside the container, run `claude` to start Claude Code
3. If you haven't logged in before, you'll be automatically prompted for credentials
4. If you were previously using API key authentication, run `/login` to switch to Max plan

## Switching Authentication Methods

If you're already logged in to Claude Code via Anthropic Console PAYG or API key and want to switch to Max plan:

1. Inside Claude Code, run `/login`
2. Follow the prompts to log in with your Claude.ai credentials

## Rate Limit Management

With the Max plan, your usage limits are shared between Claude and Claude Code:

| Plan | Claude Messages | Claude Code Prompts |
|------|----------------|---------------------|
| Max (5x Pro/$100) | ~225 messages / 5 hrs | ~50-200 prompts / 5 hrs |
| Max (20x Pro/$200) | ~900 messages / 5 hrs | ~200-800 prompts / 5 hrs |

### When You Hit Rate Limits

If you reach your rate limits, you have several options:

1. **Upgrade Your Plan**: If you're on the $100 Max plan (5x Pro usage), consider upgrading to the $200 Max plan (20x Pro usage)
2. **Switch to PAYG**: You can switch to pay-as-you-go usage with an Anthropic Console account for intensive coding sessions
3. **Wait for Reset**: Wait until your rate limits reset (generally 5 hours)

## Usage Efficiency Tips

To maximize the value of your Max plan:

1. **Plan Your Sessions**: Group your coding tasks into focused sessions to make the most of your rate limits
2. **Use Selective Auto-Accept**: Configure Claude Code to only auto-accept certain types of actions to reduce prompt usage
3. **Batch Tasks**: Send multiple related requests in a single prompt when possible
4. **Balance Usage**: Be mindful that usage is shared between Claude and Claude Code
5. **Project Complexity**: More complex projects with larger codebases will use more of your quota

## Troubleshooting

### Common Issues

1. **Authentication Errors**: Ensure you're using the same email and password as your Claude.ai account
2. **Rate Limit Warnings**: If you see warnings about remaining capacity, consider saving your most important tasks for when limits reset
3. **Login Issues**: If you're having trouble logging in, try using the API key authentication method temporarily

### Getting Help

If you encounter issues with your Max plan or Claude Code:
- Visit the [Anthropic Help Center](https://help.anthropic.com)
- For specific Max plan questions, see [Claude's Max Plan documentation](https://www.anthropic.com/claude/max)