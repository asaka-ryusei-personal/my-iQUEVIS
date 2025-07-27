import { Breadcrumb } from "react-bootstrap";
import styles from "./BreadcrumbsList.module.css";

export type Crumb = {
  label: string;
  href?: string;
  active?: boolean;
};

export type BreadcrumbsListProps = {
  crumbs: Crumb[];
};

export default function BreadcrumbsList({ crumbs }: BreadcrumbsListProps) {
  return (
    <Breadcrumb className={styles.breadcrumbs}>
      {crumbs.map((crumb, idx) => (
        <Breadcrumb.Item key={idx} href={crumb.href} active={crumb.active}>
          {crumb.label}
        </Breadcrumb.Item>
      ))}
    </Breadcrumb>
  );
}
