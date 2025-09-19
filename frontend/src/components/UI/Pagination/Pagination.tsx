import React from 'react';
import styles from './Pagination.module.css';

interface PaginationProps {
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
}

const Pagination: React.FC<PaginationProps> = ({
  currentPage,
  totalPages,
  onPageChange,
}) => {
  const pageNumbers = [];
  for (let i = 1; i <= totalPages; i++) {
    pageNumbers.push(i);
  }

  return (
    <nav className={styles.paginationContainer}>
      <ul className={styles.pagination}>
        <li className={`${styles.pageItem} ${currentPage === 1 ? styles.disabled : ''}`}>
          <button
            onClick={() => onPageChange(currentPage - 1)}
            className={styles.pageLink}
            disabled={currentPage === 1}
          >
            Anterior
          </button>
        </li>
        {pageNumbers.map((number) => (
          <li
            key={number}
            className={`${styles.pageItem} ${number === currentPage ? styles.active : ''}`}
          >
            <button onClick={() => onPageChange(number)} className={styles.pageLink}>
              {number}
            </button>
          </li>
        ))}
        <li
          className={`${styles.pageItem} ${currentPage === totalPages ? styles.disabled : ''}`}
        >
          <button
            onClick={() => onPageChange(currentPage + 1)}
            className={styles.pageLink}
            disabled={currentPage === totalPages}
          >
            Próximo
          </button>
        </li>
      </ul>
    </nav>
  );
};

export default Pagination;
