import React, { useState, useEffect } from 'react';
import './EntitySelector.css';

interface EntityOption {
  id: string;
  label: string;
  description?: string;
  data: any;
}

interface EntitySelectorProps {
  label: string;
  placeholder: string;
  options: EntityOption[];
  value?: string;
  onSelect: (entity: any) => void;
  onCreateNew?: () => void;
  loading?: boolean;
  icon?: string;
  required?: boolean;
}

export const EntitySelector: React.FC<EntitySelectorProps> = ({
  label,
  placeholder,
  options,
  value,
  onSelect,
  onCreateNew,
  loading = false,
  icon = 'icon-search',
  required = false
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedOption, setSelectedOption] = useState<EntityOption | null>(null);

  const filteredOptions = options.filter(option =>
    option.label.toLowerCase().includes(searchTerm.toLowerCase()) ||
    (option.description && option.description.toLowerCase().includes(searchTerm.toLowerCase()))
  );

  useEffect(() => {
    if (value) {
      const found = options.find(opt => opt.id === value);
      setSelectedOption(found || null);
    }
  }, [value, options]);

  const handleSelect = (option: EntityOption) => {
    setSelectedOption(option);
    setIsOpen(false);
    setSearchTerm('');
    onSelect(option.data);
  };

  const handleCreateNew = () => {
    setIsOpen(false);
    setSearchTerm('');
    if (onCreateNew) {
      onCreateNew();
    }
  };

  return (
    <div className="entity-selector">
      <label className="form-label">
        {label}
        {required && <span className="required-indicator">*</span>}
      </label>
      
      <div className={`selector-container ${isOpen ? 'open' : ''}`}>
        <button
          type="button"
          className={`selector-button ${selectedOption ? 'selected' : ''}`}
          onClick={() => setIsOpen(!isOpen)}
        >
          <i className={icon}></i>
          <span className="selector-text">
            {selectedOption ? selectedOption.label : placeholder}
          </span>
          <i className="icon-chevron-down"></i>
        </button>

        {isOpen && (
          <div className="selector-dropdown">
            <div className="selector-search">
              <i className="icon-search"></i>
              <input
                type="text"
                placeholder="Buscar..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                autoFocus
              />
            </div>

            <div className="selector-options">
              {loading ? (
                <div className="selector-loading">
                  <i className="icon-refresh-cw"></i>
                  <span>Carregando...</span>
                </div>
              ) : filteredOptions.length > 0 ? (
                <>
                  {filteredOptions.map((option) => (
                    <button
                      key={option.id}
                      type="button"
                      className={`selector-option ${selectedOption?.id === option.id ? 'selected' : ''}`}
                      onClick={() => handleSelect(option)}
                    >
                      <div className="option-content">
                        <div className="option-label">{option.label}</div>
                        {option.description && (
                          <div className="option-description">{option.description}</div>
                        )}
                      </div>
                      {selectedOption?.id === option.id && (
                        <i className="icon-check"></i>
                      )}
                    </button>
                  ))}
                  
                  {onCreateNew && (
                    <button
                      type="button"
                      className="selector-option create-new"
                      onClick={handleCreateNew}
                    >
                      <i className="icon-plus"></i>
                      <span>Cadastrar Novo</span>
                    </button>
                  )}
                </>
              ) : (
                <div className="selector-empty">
                  <i className="icon-inbox"></i>
                  <span>Nenhum item encontrado</span>
                  {onCreateNew && (
                    <button
                      type="button"
                      className="btn btn-primary btn-small"
                      onClick={handleCreateNew}
                    >
                      <i className="icon-plus"></i>
                      Cadastrar Novo
                    </button>
                  )}
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      {selectedOption && selectedOption.description && (
        <div className="selector-info">
          <i className="icon-info"></i>
          <span>{selectedOption.description}</span>
        </div>
      )}
    </div>
  );
};