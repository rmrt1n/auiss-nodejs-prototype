<script>
  import {
    Header,
    HeaderNav,
    HeaderNavItem,
    HeaderUtilities,
    HeaderGlobalAction,
    SideNav,
    SideNavLink,
    SideNavItems,
  } from 'carbon-components-svelte';
  import Sun20 from 'carbon-icons-svelte/lib/Sun20';
  import Moon20 from 'carbon-icons-svelte/lib/Moon20';

  export let theme;
  let isSideNavOpen = false;

  const changeTheme = () => {
    console.log(theme);
    theme = theme == 'g10' ? 'g90' : 'g10';
  };
</script>

<Header company="AUISS" expandedByDefault={false} bind:isSideNavOpen>
  <HeaderNav>
    <HeaderNavItem href="/" text="Home" />
    <HeaderNavItem href="/events" text="Events" />
    <HeaderNavItem href="/clubs" text="Clubs" />
    <HeaderNavItem href="/kedai" text="Kedai" />
    <HeaderNavItem href="/blog" text="Blog" />
    <HeaderNavItem href="/about" text="About" />
    <HeaderNavItem href="/signin" text="Sign In" />
  </HeaderNav>
  <HeaderUtilities>
    <HeaderGlobalAction on:click={changeTheme} icon={Sun20} closeIcon={Moon20} />
  </HeaderUtilities>
</Header>

<SideNav bind:isOpen={isSideNavOpen}>
  <SideNavItems>
    <SideNavLink href="/" text="Home" />
    <SideNavLink href="/events" text="Events" />
    <SideNavLink href="/clubs" text="Clubs" />
    <SideNavLink href="/kedai" text="Kedai" />
    <SideNavLink href="/blog" text="Blog" />
    <SideNavLink href="/about" text="About" />
    <SideNavLink href="/contact" text="Contact" />
    <SideNavLink href="/signin" text="Sign In" />
  </SideNavItems>
</SideNav>
