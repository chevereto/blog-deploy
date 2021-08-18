<template>
  <section id="header-wrapper">
    <header id="header">
      <div class="header-wrapper">
        <nav class="navbar navbar-expand-md navbar-light fixed-top">
          <div class="container">
            <NavLink link="/" class="navbar-brand">
              <img :src="$withBase($themeConfig.logo)" />
              {{ $site.title }}
            </NavLink>
            <component
              :is="isOpen ? 'XIcon' : 'MenuIcon'"
              @click="$emit('toggle-sidebar')"
            />
            <div class="collapse navbar-collapse" :class="{ open: isOpen }">
              <ul v-if="$themeConfig.nav" class="navbar-nav ml-auto">
                <li
                  v-for="item in $themeConfig.nav"
                  :key="item.text"
                  class="nav-item"
                >
                  <NavLink :link="item.link" class="nav-link">{{
                    item.text
                  }}</NavLink>
                </li>
                <SearchBox />
                <Feed />
              </ul>
            </div>
          </div>
        </nav>
      </div>
    </header>
  </section>
</template>

<script>
import { MenuIcon, XIcon } from 'vue-feather-icons'
import SearchBox from '@SearchBox'
import Feed from './Feed'
export default {
  components: { SearchBox, Feed, MenuIcon, XIcon },
  props: {
    isOpen: {
      type: Boolean,
      required: true,
    },
  },
}
</script>

<style lang="stylus">
@import '~@app/style/config';

.header-wrapper {
  .title {
    font-size: 30px;
    margin: 0;
    letter-spacing: 2px;
    display: block;
    text-transform: uppercase;

    a {
      color: $darkTextColor;
      font-weight: bold;
      text-decoration: none;
    }
  }

  .header-right-wrap {
    flex: 1;
    display: flex;
    justify-content: flex-end;
    align-items: center;

    .nav {
      flex: 0 0 auto;
      display: flex;
      margin: 0;

      .nav-item {
        margin-left: 20px;

        a {
          text-decoration: none;
          transition: color 0.3s;
        }
      }
    }

    .search-box {
      margin-left: 20px;

      input {
        border-radius: 5px;
        transition: all 0.5s;
        border: 1px solid #cecece;

        &:hover {
          border: 1px solid $accentColor;
          box-shadow: 0 0 5px $accentColor;
        }
      }

      .suggestions {
        border: 1px solid $darkBorderColor;
        top: 40px;
        right: 0;

        a {
          color: $darkTextColor;
          text-decoration: none;

          &.focused {
            color: $accentColor;
          }
        }
      }
    }
  }
}

.collapse.navbar-collapse.open {
  transition: 0.3s ease;
  display: block;
}

@media (max-width: $MQMobile) {
  .header-wrapper {
    flex-direction: column;

    .header-right-wrap {
      display: none;
    }
  }
}

.search-box {
  input {
    border-color: darken($borderColor, 10%);
  }
}

@media (max-width: 768px) {
  .navbar.navbar-expand-md {
    padding: 1.2rem;
    transition: all 1s cubic-bezier(0.25, 0.8, 0.25, 1);
    display: flex;
    align-items: center;
    justify-content: space-between;
    overflow: hidden;
    transition: 0.3s ease;
  }
}

#header {
  .feather-menu {
    display: block;
  }
}

@media (min-width: 768px) {
  #header {
    .feather-menu {
      display: none;
    }
  }
}
</style>
